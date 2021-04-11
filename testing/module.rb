module TestModule
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    def instances(v)
      @instances ||= 0
      @instances += 1
      class << self
        self.class_eval %(
        attr_accessor :instances
        )
      end
      args.each do |arg|
        class_eval %(
          class << self; attr_accessor :#{arg} end
        )
      end
      @inheritable_attributes
    end

    ||=
  end

  module InstanceMethods
  end

end
