require_relative '04_associatable2'

module Associatable
  def has_many_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      # belongs_to => has_many
      if through_options.is_a?(BelongsToOptions)
        result = DBConnection.execute(<<-SQL, send(through_options.foreign_key))
        SELECT
          #{source_options.table_name}.*
        FROM
          #{source_options.table_name}
        JOIN
          #{through_options.table_name}
        ON
          #{source_options.table_name}.#{source_options.foreign_key} =
            #{through_options.table_name}.#{through_options.primary_key}
        WHERE
          #{source_options.table_name}.#{source_options.foreign_key} = ?
        SQL
        
      # has_many => belongs_to
      else
        result = DBConnection.execute(<<-SQL, self.id)
        SELECT DISTINCT
          #{source_options.table_name}.*
        FROM
          #{source_options.table_name}
        JOIN
          #{through_options.table_name}
        ON
          #{source_options.table_name}.#{source_options.primary_key} =
            #{through_options.table_name}.#{source_options.foreign_key}
        WHERE
          #{through_options.table_name}.#{through_options.primary_key}
        IN
          (
            SELECT
              #{through_options.table_name}.#{through_options.primary_key}    
            FROM
              #{through_options.table_name}
            JOIN
              #{self.class.table_name}
            ON
              #{self.class.table_name}.id =
                #{through_options.table_name}.#{through_options.foreign_key}
            WHERE
              #{self.class.table_name}.id = ?
          )
        SQL
      end

      source_options.model_class.parse_all(result)
    end
  end
end