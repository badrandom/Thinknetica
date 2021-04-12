module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def instances
      self.instance_variable_get(:@instances)
    end

  end

  module InstanceMethods

    def register_instance
      instances = self.class.instance_variable_get(:@instances)
      if instances
        self.class.instance_variable_set(:@instances, instances + 1)
      else
        class << self
          attr_accessor :instances
        end
        self.class.instance_variable_set(:@instances, 1)
      end
    end

  end
end
