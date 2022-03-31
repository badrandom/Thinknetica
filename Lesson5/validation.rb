module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def validate(parameter, type, *args)
      new_object = self.send(parameter)
      send(type, new_object, *args)
    end

    def presence(name)
      raise ArgumentError, 'Name should not be nil' if name.nil? || name == ''
    end

    def format(object, format)
      raise ArgumentError, 'Wrong format' unless object =~ format
    end

    def type(object, object_type)
      raise TypeError, 'Wrong type' unless object.instance_of?(object_type)
    end
  end


end