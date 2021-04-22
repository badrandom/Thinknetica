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
    validate!
    register_instance
    @@stations << self
    #rescue StandardError => e #убрал, тк в задании сказано убрать все puts. Исключение все равно будет выбрасываться, но не будет обработки
    #puts e.message
  end

  def each_train(&block)
    @trains.each { |train| yield(train) }
  end

  def valid?
    validate!
    true
  rescue
    false
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

  protected

  def validate!
    raise ArgumentError, "Name can't be nil" if @name.nil?
    raise ArgumentError, "Name can't be empty" if @name.size.zero?
  end

end
