require 'active_support/inflector'

module Save
  
  def save
    if id.nil? 
      create_row
    else
      update_row
    end
  end

  def update_row
    command = <<-SQL
    UPDATE 
    #{table_name}
    SET 
     #{column_assignment}
    WHERE 
      id = #{id}
    SQL
  
    QuestionsDatabase.instance.execute(command)
  end

  def create_row
    command = <<-SQL
    INSERT INTO 
     #{table_name} (#{create_column_list} ) 
    VALUES 
    (#{create_column_values})
    SQL
    
    p create_column_list
    p create_column_values
  
    QuestionsDatabase.instance.execute(command)
    @id = QuestionsDatabase.instance.last_insert_row_id
  end
  
  def table_name
    self.class.to_s.tableize
  end
  
  def column_assignment
    self.instance_variables.map do |ivar|
      "#{ivar.to_s[1..-1]} = #{self.instance_variable_get(ivar)}"
    end.join(', ')
  end
  
  def create_column_list
    list = self.instance_variables.map do |ivar|
      ivar = ivar.to_s[1..-1]
    end
    list[1..-1].join(', ')
  end
  
  def create_column_values
    list = self.instance_variables.map do |ivar|
      self.instance_variable_get(ivar)
    end
    list[1..-1].join(', ')
  end
  
end

