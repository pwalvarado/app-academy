require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.singularize.constantize
  end

  def table_name
    class_name.underscore.downcase + 's'
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @class_name = name.to_s.singularize.camelcase
    @foreign_key = "#{name.to_s.underscore}_id".to_sym
    @primary_key = :id
    options.keys.each do |attr|
      send("#{attr}=", (options[attr] || send(attr)))
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = "#{self_class_name.underscore}_id".to_sym
    @class_name = name.to_s.singularize.camelcase
    @primary_key = :id
    options.keys.each do |attr|
      send("#{attr}=", (options[attr] || send(attr)))
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options
    define_method(name) do
      foreign_key_val = send(options.foreign_key)
      options.model_class.where(options.primary_key => foreign_key_val).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do
      primary_key_val = send(options.primary_key)
      options.model_class.where(options.foreign_key => primary_key_val)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
