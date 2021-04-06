# frozen_string_literal: true

class Route

  attr_reader :stations, :id

  def initialize(id, start_station, finish_station)
    @id = id
    @stations = [start_station, finish_station]
  end

  def add_station(station)
    @stations.insert(@stations.size - 1, station)
  end

  def remove_station(station)
    @stations.delete(station)
  end

end
