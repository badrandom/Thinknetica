#frozen_string_literal: true

class Station

  attr_reader :trains_in_queue, :num_of_cargo_trains, :num_of_passenger_trains, :name

  def initialize(name)
    @name = name
    @num_of_passenger_trains = 0
    @num_of_cargo_trains = 0
    @trains_in_queue = []
  end

  def add_train(train)
    @trains_in_queue << train
    @num_of_passenger_trains += 1 if train.type == 'passenger'
    @num_of_cargo_trains += 1 if train.type == 'cargo'
  end

  def send_train(train)
    if train.type == 'passenger'
      @num_of_passenger_trains -= 1
    else
      @num_of_cargo_trains -= 1
    end
    trains_in_queue.delete(train)
  end
end

class Train
  attr_reader :current_speed, :num_of_wagons, :current_station, :type
  @current_route

  def initialize(number = "unknown", type = "unknown", num_of_wagons = 0)
    @number = number
    @type = type
    @num_of_wagons = num_of_wagons
    stop
  end



  def add_wagon
    if @current_speed == 0
      @num_of_wagons += 1
    else
      puts "Stop the train!"
    end
  end

  def remove_wagon
    if @current_speed == 0
      @num_of_wagons -= 1
    else
      puts "Stop the train!"
    end
  end

  def add_route(route)
    @current_route = route
    route.stations.first.add_train(self)
    @current_station = route.stations.first
    @current_station_index = 0
  end

  def move_forward
    if @current_route.stations.size - 1 != @current_station_index
      @current_station.send_train(self)
      start_moving #Ну, зачем-то же надо было их делать
      stop
      @current_station_index += 1
      check_current_station
      @current_station.add_train(self)
    else
      'Error'
    end
  end

  def move_back
    if @current_station_index > 0
      @current_station.send_train(self)
      start_moving
      stop
      @current_station_index -= 1
      check_current_station
      @current_station.add_train(self)
    else
      'Error'
    end
  end

  def next_station
    @current_route.stations[@current_station_index + 1]
    if @current_station_index <= @current_route.stations.size + 1
      @current_route.stations[@current_station_index + 1]
    end
  end

  def previous_station
    if @current_station_index != 0
      @current_route.stations[@current_station_index - 1]
    end
  end

  private
  def check_current_station
    @current_station = @current_route.stations[@current_station_index]
  end

  def start_moving
    @current_speed = 150 #km/h. Не совсем понятно, что значит 'умеет набирать скорость'.
    # Я бы использовал сеттер, но тогда он сможет не набирать, а устанавливать скорость. Так же в этом случае теряется смысл метода stop.
    # Предположим, что именно такая реализация необходима в программе, а 150 km/h - разрешенная скорость.
  end

  def stop
    @current_speed = 0
  end
end

class Route

  attr_reader :stations

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = [@start_station, @finish_station]
  end

  def add_station(station)
    @stations.insert(@stations.size - 1, station)
  end

  def print_stations
    @stations.each { |station| print "#{station.name}, " }
  end
end

my_train = Train.new('7s7dhh7', 'passenger', 8)
first_station = Station.new('First station')
second_station = Station.new('Second station')
third_station = Station.new('Third station')
fourth_station = Station.new('Fourth station')
my_route = Route.new(first_station, fourth_station)
my_route.add_station(second_station)
my_route.add_station(third_station)
my_train.add_route(my_route)

puts " Enter command or 'stop'"
puts "'Move forward' to move forward"
puts "'Move back' to move back"
puts "Current: #{my_train.current_station.name}"
puts "Previous: #{my_train.previous_station.name if my_train.previous_station.instance_of?(Station)}"
puts "Next: #{my_train.next_station.name if my_train.next_station.instance_of?(Station)}"
loop do
  puts "Enter command"

  command = gets.chomp.capitalize
  case command
  when 'Move forward'
    my_train.move_forward
    puts "Current: #{my_train.current_station.name}"
    puts "Previous: #{my_train.previous_station.name if my_train.previous_station.instance_of?(Station)}"
    puts "Next: #{my_train.next_station.name if my_train.next_station.instance_of?(Station)}"
  when 'Move back'
    my_train.move_back
    puts "Current: #{my_train.current_station.name}"
    puts "Previous: #{my_train.previous_station.name if my_train.previous_station.instance_of?(Station)}"
    puts "Next: #{my_train.next_station.name if my_train.next_station.instance_of?(Station)}"
  when 'Stop'
    break
  end
end
