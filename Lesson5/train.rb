# frozen_string_literal: true

require_relative 'wagon'
class Train
  attr_accessor :current_speed
  attr_reader :number

  @current_route

  def initialize(number)
    @number = number
    @current_speed = 0
    @wagons = []
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
    if @current_speed == 0
      @wagons.pop
    else
      puts "Stop the train!"
    end
  end

  protected
  # Метод, который я переопределю в классе потомке. Там проведу проверку на соответствие типу и вызову оригинал посредством super.
  # Т.к. Буду вызывать его из класса потомка, то помещаю в секцию protected.
  # Нет смысла проводить проверку на соответствие типа для метода удаления вагона, поэтому оставляю его публичным.
  def add_wagon(wagon)
    if @current_speed == 0
      @wagons << wagon
    else
      puts "Stop the train!"
    end
  end

end

# Class for passenger type
class PassengerTrain < Train
  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    super(wagon) if wagon.instance_of?(PassengerWagon)
  end

  def type
    'Passenger'
  end
end

# Class for cargo type
class CargoTrain < Train
  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    super(wagon) if wagon.instance_of?(CargoWagon)
  end

  def type
    'Cargo'
  end
end
