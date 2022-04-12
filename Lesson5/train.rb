# frozen_string_literal: true
# "Number must be like: 'xxx-xx'; where 'x' is a letter or number"

require_relative 'instance_counter'
require_relative 'wagon'
require_relative 'validation'
require_relative 'accessors'
class Train
  include InstanceCounter
  include Accessors

  @@trains = []
  strong_attr_accessor :current_speed, :Integer
  attr_reader :number, :wagons

  def initialize(number)
    @number = number.upcase
    @current_speed = 0
    @wagons = []
    register_instance
    @@trains << self
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def each_wagon(&block)
    @wagons.each(&block)
  end

  def add_route(route)
    @current_route = route
    route.stations.first.add_train(self)
    @current_station = route.stations.first
    @current_station_index = 0
  end

  def move_forward
    return unless next_station

    current_station.send_train(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def move_back
    return unless previous_station

    @current_station.send_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def next_station
    @current_route.stations[@current_station_index + 1] if @current_station_index <= @current_route.stations.size + 1
  end

  def previous_station
    @current_route.stations[@current_station_index - 1] if @current_station_index != 0
  end

  def current_station
    @current_station = @current_route.stations[@current_station_index]
  end

  def num_of_wagons
    @wagons.length
  end

  def remove_wagon
    raise 'Stop the train!' unless @current_speed.zero?

    @wagons.pop
  rescue RuntimeError => e
    e.message
  end

  protected

  # Метод, который я переопределю в классе потомке.
  # Там проведу проверку на соответствие типу и вызову оригинал посредством super.
  # Т.к. Буду вызывать его из класса потомка, то помещаю в секцию protected.
  # Нет смысла проводить проверку на соответствие типа для метода удаления вагона, поэтому оставляю его публичным.
  def add_wagon(wagon)
    raise 'Stop the train!' unless @current_speed.zero?

    @wagons << wagon
  rescue RuntimeError => e
    e.message
  end

end

# Class for passenger type
class PassengerTrain < Train
  include Validation
  validate :number, :format, /^[A-Z|\d]{3}[-][A-Z|\d]{2}$/i

  def initialize(number)
    super
    valid?
  end

  def add_wagon(wagon)
    super(wagon) if wagon.type == 'Passenger'
  end

  def type
    'Passenger'
  end
end

# Class for cargo type
class CargoTrain < Train
  include Validation
  validate :number, :format, /^[A-Z|\d]{3}[-][A-Z|\d]{2}$/i

  def initialize(number)
    super
    valid?
  end

  def add_wagon(wagon)
    super(wagon) if wagon.type == 'Cargo'
  end

  def type
    'Cargo'
  end
end
