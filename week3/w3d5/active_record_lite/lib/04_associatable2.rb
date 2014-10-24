require_relative '03_associatable'

module Associatable
  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      sql_result = DBConnection.execute(<<-SQL)
      SELECT
        #{source_options.table_name}.*
      FROM
        #{source_options.table_name}
      JOIN
        #{through_options.table_name}
      ON
        #{source_options.table_name}.#{source_options.primary_key} = #{through_options.table_name}.#{source_options.foreign_key}
      WHERE
        #{through_options.table_name}.#{through_options.primary_key} = #{send(through_options.foreign_key)}
      SQL

      source_options.model_class.parse_all(sql_result).first
    end
  end
end