# frozen_string_literal: true
require_relative 'instance_counter'

class Station
  include InstanceCounter
  @@stations = []
  attr_reader :trains, :name

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@stations << self
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def types
    types = {passenger: 0, cargo: 0}
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
