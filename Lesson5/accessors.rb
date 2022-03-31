#Accessors

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history (*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@#{name}_history".to_sym
        define_method(name) do
          instance_variable_get(var_name)
        end
        define_method("#{name}_history".to_sym) do
          instance_variable_get(var_history_name)
        end
        define_method("#{name}=".to_sym) do |v|
          instance_variable_set(var_name, v)
          instance_variable_set(var_history_name, []) unless instance_variable_get(var_history_name)
          instance_variable_get(var_history_name).push(v)
        end
      end
    end

    def strong_attr_accessor (name, type)
      var_name = "@#{name}".to_sym
      define_method(name) do
        instance_variable_get(var_name)
      end

      define_method("#{name}=".to_sym) do |v|
        begin
          raise TypeError, 'Wrong type!' unless v.class.to_s.downcase == type.to_s.downcase
          instance_variable_set(var_name, v)
        rescue TypeError => e
          puts e.message
        end
      end
    end
  end
end