module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    class << self
      attr_accessor :instances
    end

    def instances
      @instances
    end

  end

  module InstanceMethods
    def register_instance
      @instances += 1
    end
  end
end
