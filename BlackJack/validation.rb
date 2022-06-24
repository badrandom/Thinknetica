# frozen_string_literal: true

module Validation
  def self.included(base)
    # base.extend ClassMethods
    base.include InstanceMethods
  end

  module InstanceMethods
    def validate!(type, *args)
      send("validate_#{type}", *args)
    end

    def validate_type(object, type)
      raise TypeError, "Error: Object must be instance of #{type}" unless object.is_a?(type)
    end
  end
end
