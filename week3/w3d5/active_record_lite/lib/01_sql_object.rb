require_relative 'db_connection'
require 'active_support/inflector'

class SQLObject
  # array of attributes/columns as symbols
  def self.columns
    DBConnection.execute2(<<-SQL).first.map(&:to_sym)
      SELECT
        *
      FROM
        #{table_name}
      SQL
  end

  def self.finalize!
    # getters
    columns.each do |ivar|
      define_method(ivar) do
        attributes[ivar]
      end
    end

    # setters
    columns.each do |ivar|
      define_method("#{ivar}=") do |val|
        attributes[ivar] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    parse_all(DBConnection.execute(<<-SQL))
    SELECT
      *
    FROM
      #{table_name}
    SQL
  end

  def self.parse_all(results)
    results.map do |attributes_hash|
      new(attributes_hash)
    end
  end

  def self.find(id)
    parse_all(DBConnection.execute(<<-SQL, id)).first
    SELECT
      #{table_name}.*
    FROM
      #{table_name}
    WHERE
      id = ?
    SQL
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      if !self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      else
        attributes[attr_name] = value
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |ivar| send(ivar) }
  end

  def insert
    col_names = self.class.columns.join(', ')
    question_marks = (['?'] * self.class.columns.size).join(', ')
    
    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns
      .map { |attr_name| "#{attr_name} = ?" }
      .join(', ')

    DBConnection.execute(<<-SQL, *attribute_values, id)
    UPDATE
      #{self.class.table_name}
    SET
      #{set_line}
    WHERE
      id = ?
    SQL
  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end
end