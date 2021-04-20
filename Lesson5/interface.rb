# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'

class Interface

  def start
    @stations = {}
    @routes = {}
    @trains = {}

    # Инструкцию по работе оставлю в ReadMe
    loop do
      instructions

      command = gets.chomp
      case command
      when '1' # add a new station
        add_new_station
      when '2' # add a new train
        add_new_train
      when '3' # see all trains
        print_trains
      when '4' # add a new route
        add_new_route
      when '5' # see all routes
        print_routes
      when '6' # modify a route
        modify_route
      when '7' # set train on a route
        set_train_on_route
      when '8' # choose a train to move forward
        move_forward
      when '9' # choose a train to move back
        move_back
      when '10' # choose a train and add a wagon
        add_wagon
      when '11' # choose a train and remove a wagon
        remove_wagon
      when '12' # choose a route and observe its stations
        observe_stations_on_route
      when '13' # see all stations
        print_stations
      when 'Stop'
        break
      end
    end
  end

  private

  def instructions
    puts "Enter a command"
    puts "'1' to add a new station"
    puts "'2' to add a new train"
    puts "'3' to see all trains"
    puts "'4' to add a new route"
    puts "'5' to see all routes"
    puts "'6' to modify a route"
    puts "'7' to set train on a route"
    puts "'8' to choose a train to move forward"
    puts "'9' to choose a train to move back"
    puts "'10' to choose a train and add a wagon"
    puts "'11' to choose a train and remove a wagon"
    puts "'12' to choose a route and observe its stations"
    puts "'13' to see all stations"
    puts "'Stop' to finish the program"
  end

  def add_new_station
    puts 'Enter its name'
    name = gets.chomp.capitalize
    @stations[name] = Station.new(name)
  end

  def add_new_train
    begin
    puts 'Enter type: Passenger or Cargo'
    type = gets.chomp.capitalize
    if type != 'Passenger' && type != 'Cargo'
      raise ArgumentError, 'Wrong type'
    end
    rescue StandardError => e
      puts e.message
      retry
    end
    begin
      puts 'Enter its number'
      puts "Number must be like: 'xxx-xx'; where 'x' is a letter or number"
    if type == 'Passenger'
      number = gets.chomp
      train = PassengerTrain.new(number)
      @trains[number] = train
    end
    if type == 'Cargo'
      number = gets.chomp
      @trains[number] = CargoTrain.new(number)
    end
      puts "Train with number #{number} was successfully created"
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def print_trains
    @trains.each_key { |number| puts "Number:#{number}, Type:#{@trains[number].type}, Wagons:#{@trains[number].num_of_wagons}" }
  end

  def add_new_route
    puts 'Enter route id'
    route_id = gets.chomp
    puts 'Enter first station'
    first = gets.chomp.capitalize
    puts 'Enter last station'
    last = gets.chomp.capitalize
    @routes[route_id] = Route.new(route_id, @stations[first], @stations[last])
  end

  def self.print_routes
    @routes.each_key { |id| print "#{id}: First - #{@routes[id].stations.first.name} Last - #{@routes[id].stations.last.name}" }
    puts
  end

  def modify_route
    puts 'Enter route id'
    id = gets.chomp
    puts 'Enter Add or Remove to add or remove a station'
    command = gets.chomp.capitalize
    puts 'Enter station'
    station = gets.chomp.capitalize
    case command
    when 'Add'
      @routes[id].add_station(@stations[station])
    when 'Remove'
      @routes[id].remove_station(@stations[station])
    end
  end

  def set_train_on_route
    puts 'Enter train number'
    train_number = gets.chomp
    puts 'Enter route id'
    route_id = gets.chomp
    @trains[train_number].add_route(@routes[route_id]) if @routes[route_id] && @trains[train_number]
  end

  def move_forward
    puts 'Enter train number'
    train_number = gets.chomp
    if @trains[train_number]
      @trains[train_number].move_forward
      puts "Current: #{@trains[train_number].current_station.name}"
      puts "Previous: #{@trains[train_number].previous_station.name if @trains[train_number].previous_station.instance_of?(Station)}"
      puts "Next: #{@trains[train_number].next_station.name if @trains[train_number].next_station.instance_of?(Station)}"
      puts "Cargo trains on #{@trains[train_number].current_station.name}: #{@trains[train_number].current_station.types[:cargo]}"
      puts "Passenger trains on #{@trains[train_number].current_station.name}: #{@trains[train_number].current_station.types[:passenger]}"
    end
  end

  def move_back
    puts 'Enter train number'
    train_number = gets.chomp
    if @trains[train_number]
      @trains[train_number].move_back
      puts "Current: #{@trains[train_number].current_station.name}"
      puts "Previous: #{@trains[train_number].previous_station.name if @trains[train_number].previous_station.instance_of?(Station)}"
      puts "Next: #{@trains[train_number].next_station.name if @trains[train_number].next_station.instance_of?(Station)}"
      puts "Cargo trains on #{@trains[train_number].current_station.name}: #{@trains[train_number].current_station.types[:cargo]}"
      puts "Passenger trains on #{@trains[train_number].current_station.name}: #{@trains[train_number].current_station.types[:passenger]}"
    end
  end

  def add_wagon
    puts 'Enter train number'
    number = gets.chomp
    if @trains[number].type == 'Passenger'
      @trains[number].add_wagon(PassengerWagon.new)
    else
      @trains[number].add_wagon(CargoWagon.new)
    end
  end

  def remove_wagon
    puts 'Enter train number'
    number = gets.chomp
    @trains[number].remove_wagon
  end

  def observe_stations_on_route
    puts 'Enter route id'
    route_id = gets.chomp
    @routes[route_id].stations.each do |station|
        puts "#{station.name} Cargo:#{station.types[:cargo]}, Passenger:#{station.types[:passenger]}"
    end
  end

  def print_stations
    @stations.each_key { |name| puts name.to_s}
  end
end
