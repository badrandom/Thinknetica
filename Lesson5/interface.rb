# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'

class Interface
  INSTRUCTIONS = [
    "Enter a command'", "'1' to add a new station", "'2' to add a new train",
    "'3' to see all trains", "'4' to add a new route", "'5' to see all routes",
    "'6' to modify a route", "'7' to set train on a route", "'8' to choose a train to move forward",
    "'9' to choose a train to move back", "'10' to choose a train and add a wagon",
    "'11' to choose a train and remove a wagon", "'12' to choose a route and observe its stations",
    "'13' to see all stations", "'14' to choose a train and observe its wagons",
    "'15' to choose a station and observe all trains on it", "'16' to take some seats on a passenger train",
    "'17' to put some cargo on a cargo train", "'Stop' to finish the program"
  ].freeze

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
      when '14'
        list_of_wagons
      when '15'
        list_of_trains
      when '16'
        take_seats
      when '17'
        put_some_cargo
      when 'Stop'
        break
      end
    end
  end

  def print_routes
    @routes.each_key do |id|
      print "#{id}: First - #{@routes[id].stations.first.name} Last - #{@routes[id].stations.last.name}"
    end
    puts
  end

  private

  def instructions
    INSTRUCTIONS.each { |i| puts i }
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
      raise ArgumentError, 'Wrong type' if type != 'Passenger' && type != 'Cargo'
    rescue StandardError => e
      puts e.message
      retry
    end
    begin
      generate_train(type)
    rescue StandardError => e
      puts e.message
    retry
    end
  end

  def generate_train(type)
    puts 'Enter its number'
    puts "Number must be like: 'xxx-xx'; where 'x' is a letter or number"
    if type == 'Passenger'
      number = gets.chomp
      @trains[number] = PassengerTrain.new(number)
    end
    if type == 'Cargo'
      number = gets.chomp
      @trains[number] = CargoTrain.new(number)
    end
    puts "Train with number #{number} was successfully created"
  end

  def print_trains
    @trains.each_key do |number|
      puts "Number:#{number}, Type:#{@trains[number].type}, Wagons:#{@trains[number].num_of_wagons}"
    end
  end

  def add_new_route
    puts 'Enter route id'
    route_id = gets.chomp
    puts 'Enter first station'
    first = gets.chomp.capitalize
    puts 'Enter last station'
    last = gets.chomp.capitalize
    @routes[route_id] = Route.new(route_id, @stations[first], @stations[last])
  rescue StandardError => e
    puts e.message
    retry
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
    return unless @trains[train_number]

    @trains[train_number].move_forward
    output(train_number)
  end

  def move_back
    puts 'Enter train number'
    train_number = gets.chomp
    return unless @trains[train_number]

    @trains[train_number].move_back
    output(train_number)
  end

  def add_wagon
    begin
      raise 'There are no trains!' if @trains.size.zero?

      puts 'Enter train number'
      number = gets.chomp
      raise ArgumentError, 'Wrong number' if @trains[number].nil?
    rescue ArgumentError => e
      puts e.message
      retry
    rescue RuntimeError => e
      puts e.message
      return
    end
    @trains[number].add_wagon(generate_wagon(number))
  end

  def generate_wagon(number)
    wagon_number = @trains[number].wagons.size + 1 # Генерирую номер вагона.
    if @trains[number].type == 'Passenger'
      puts 'Your train is passenger. You are able to create and add a passenger wagon.'
      puts 'Please, enter its number of seats:'
      num_of_seats = gets.chomp.to_i
      PassengerWagon.new(num_of_seats, wagon_number)
    else
      puts 'Your train is cargo. You are able to create and add a cargo wagon.'
      puts 'Please, enter its capacity in tons:'
      capacity_in_tons = gets.chomp.to_i
      CargoWagon.new(capacity_in_tons, wagon_number)
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
    @stations.each_key { |name| puts name.to_s }
  end

  def list_of_wagons
    puts 'Enter train number:'
    number = gets.chomp.upcase
    raise 'There are no trains!' if @trains.size.nil?
    raise ArgumentError, 'Wrong number' if @trains[number].nil?

    puts "Train #{number}: "
    @trains[number].each_wagon do |wagon|
      print "Number: #{wagon.number} , Type: #{wagon.type}, "
      if wagon.type == 'Passenger'
        print "Free seats: #{wagon.free_seats}, "
        print "Busy seats: #{wagon.busy_seats}"
      else
        print "Free capacity: #{wagon.free_capacity}, "
        print "Busy capacity: #{wagon.busy_capacity}"
      end
      puts
    end
  rescue ArgumentError => e
    puts e.message
    retry
  rescue RuntimeError => e
    puts e.message
    nil
  end

  def list_of_trains
    begin
      raise 'There are no stations yet!' if @stations.size.zero?

      puts 'Please, enter the station name'
      name = gets.chomp.capitalize
      raise ArgumentError, 'There is no such a station!' if @stations[name].nil?
    rescue ArgumentError => e
      puts e.message
      retry
    rescue RuntimeError => e
      puts e.message
      return
    end
    station = @stations[name]
    station.each_train do |train|
      puts "Train #{train.number}: "
      print "Type: #{train.type}, Number of wagons: #{train.wagons.size}."
      puts
    end
  end

  def take_seats
    raise 'There are no trains!' if @trains.size.zero?

    puts 'Enter train number'
    number = gets.chomp.upcase
    raise 'There are no wagons!' if @trains[number].wagons.size.zero?
    raise 'It is not a passenger train' if @trains[number].type != 'Passenger'

    train = @trains[number]
    print 'Wagons available: '
    train.each_wagon do |wagon|
      print "#{wagon.number}; "
    end
    puts
    puts 'Choose a wagon'
    wagon_number = gets.chomp.to_i - 1
    puts "There are #{train.wagons[wagon_number].free_seats} seats available"
    puts 'How many seats do you want to take?'
    num_of_seats = gets.chomp.to_i
    num_of_seats.times do
      train.wagons[wagon_number].take_a_seat
    end
  rescue StandardError => e
    puts e.message
    nil
  end

  def put_some_cargo
    raise 'There are no trains!' if @trains.size.zero?

    puts 'Enter train number'
    number = gets.chomp.upcase
    raise 'It is not a cargo train' if @trains[number].type != 'Cargo'
    raise 'There are no wagons!' if @trains[number].wagons.size.zero?

    train = @trains[number]
    print 'Wagons available: '
    train.each_wagon do |wagon|
      print "#{wagon.number}; "
    end
    puts
    puts 'Choose a wagon'
    wagon_number = gets.chomp.to_i - 1
    puts "There are #{train.wagons[wagon_number].free_capacity} tons available"
    puts 'How many tons do you want to put there?'
    tons = gets.chomp.to_i
    train.wagons[wagon_number].add_cargo(tons)
  rescue StandardError => e
    puts e.message
    nil
  end

  def output(train_number)
    current_station = @trains[train_number].current_station
    previous_station = @trains[train_number].previous_station
    next_station = @trains[train_number].next_station
    puts "Current: #{current_station.name}"
    puts "Previous: #{previous_station.name if previous_station.instance_of?(Station)}"
    puts "Next: #{next_station.name if next_station.instance_of?(Station)}"
    puts "Cargo trains on #{current_station.name}: #{current_station.types[:cargo]}"
    puts "Passenger trains on #{current_station.name}: #{current_station.types[:passenger]}"
  end
end
