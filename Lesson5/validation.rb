module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations
    def validate(var_name, type, *args)
      @validations ||= []
      @hash = { var_name: var_name, type: type, argument: args[0] }
      @validations << @hash
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |hash|
        name = send(hash[:var_name])
        argument = hash[:argument]
        send("validate_#{hash[:type]}", name, argument)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError => e
      puts e.message
      false
    end

    def validate_presence(name, *args)
      raise ArgumentError, 'Error: Name should not be nil' if name == '' || name.nil?
    end

    def validate_format(number, format)
      raise ArgumentError, 'Error: Wrong format' unless number =~ format
    end

    def validate_type(object, object_type)
      raise TypeError, 'Error: Wrong type' unless object.class == object_type
    end
  end


end