class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # getters
    names.each do |name|
      define_method(name) do
        instance_variable_get("@#{name}")
      end
    end

    # setters
    names.each do |name|
      define_method("#{name}=") do |val|
        instance_variable_set("@#{name}", val)
      end
    end
  end
end