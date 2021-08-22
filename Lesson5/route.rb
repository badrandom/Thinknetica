# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :id

  def initialize(id, start_station, finish_station)
    @id = id
    @stations = [start_station, finish_station]
    validate!
    register_instance
    # rescue Exception => e #убрал, тк в задании сказано убрать все puts. Исключение все равно будет выбрасываться, но не будет обработки
    # puts e.message
  end

  def add_station(station)
    @stations.insert(@stations.size - 1, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise ArgumentError, "Route can't be zero" if @id.to_i.zero?
    raise ArgumentError, "Route can't be nil" if @id.nil?
    raise ArgumentError, 'There must be two stations' if @stations[0].nil? || stations[1].nil?
  end
end
