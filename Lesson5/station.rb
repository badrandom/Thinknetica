# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation
  @@stations = []
  attr_reader :trains, :name
  validate :name, :presence

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@stations << self
    valid?
  end

  def each_train(&block)
    @trains.each(&block)
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def types
    types = { passenger: 0, cargo: 0 }
    trains.each do |train|
      if train.type == 'Passenger'
        types[:passenger] += 1
      else
        types[:cargo] += 1
      end
    end
    types
  end

end
