#frozen_string_literal: true

class Station

  attr_reader :trains, :num_of_cargo_trains, :num_of_passenger_trains, :name

  def initialize(name)
    @name = name
    @trains = []
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
      if train.type == "passenger"
        types[:passenger] += 1
      else
        types[:cargo] += 1
      end
    end
    types
  end

end

class Train
  attr_reader :num_of_wagons, :current_station, :type
  attr_accessor :current_speed
  @current_route

  def initialize(number, type, num_of_wagons = 0)
    @number = number
    @type = type
    @num_of_wagons = num_of_wagons
    @current_speed = 0
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
    if @current_station_index <= @current_route.stations.size + 1
      @current_route.stations[@current_station_index + 1]
    end
  end

  def previous_station
    if @current_station_index != 0
      @current_route.stations[@current_station_index - 1]
    end
  end

  def current_station
    @current_station = @current_route.stations[@current_station_index]
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
puts "Cargo trains on #{my_train.current_station.name}: #{my_train.current_station.types[:cargo]}"
puts "Passenger trains on #{my_train.current_station.name}: #{my_train.current_station.types[:passenger]}"

loop do
  puts "Enter command"

  command = gets.chomp.capitalize
  case command
  when 'Move forward'
    my_train.move_forward
    puts "Current: #{my_train.current_station.name}"
    puts "Previous: #{my_train.previous_station.name if my_train.previous_station.instance_of?(Station)}"
    puts "Next: #{my_train.next_station.name if my_train.next_station.instance_of?(Station)}"
    puts "Cargo trains on #{my_train.current_station.name}: #{my_train.current_station.types[:cargo]}"
    puts "Passenger trains on #{my_train.current_station.name}: #{my_train.current_station.types[:passenger]}"
  when 'Move back'
    my_train.move_back
    puts "Current: #{my_train.current_station.name}"
    puts "Previous: #{my_train.previous_station.name if my_train.previous_station.instance_of?(Station)}"
    puts "Next: #{my_train.next_station.name if my_train.next_station.instance_of?(Station)}"
    puts "Cargo trains on #{my_train.current_station.name}: #{my_train.current_station.types[:cargo]}"
    puts "Passenger trains on #{my_train.current_station.name}: #{my_train.current_station.types[:passenger]}"
  when 'Stop'
    break
  end
end
