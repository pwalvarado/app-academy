require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map do |key|
      "#{key} = ?"
    end.join(' AND ')

    parse_all(DBConnection.execute(<<-SQL, *params.values))
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      #{where_line}
    SQL
  end

  def parse_all(results)
    results.map do |attributes_hash|
      self.new(attributes_hash)
    end
  end
end

class SQLObject
  extend Searchable
end
