# frozen_string_literal: true

require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'

stations = {}
routes = {}
trains = {}

# Инструкцию по работе оставлю в ReadMe
loop do
  puts "Enter a command"
  puts "'New station' to add a new station"
  puts "'New train' to add a new train"
  puts "'Trains' to see all trains"
  puts "'New route' to add a new route"
  puts "'Routes' to see all routes"
  puts "'Modify route'"
  puts "'Set train on route'"
  puts "'Move forward' to choose a train to move forward"
  puts "'Move back' to choose a train to move back"
  puts "'Add wagon' to choose a train and add a wagon"
  puts "'Remove wagon' to choose a train and remove a wagon"
  puts "'Stations on route' to choose a route and observe its stations"
  puts "'Stations' to see all stations"
  puts "'Stop' to finish the program"

  command = gets.chomp.capitalize!
  case command
  when 'New station'
    puts 'Enter its name'
    command = gets.chomp.capitalize!
    stations[command] = Station.new(command)
  when 'New train'
    puts 'Enter type: Passenger or Cargo'
    type = gets.chomp.capitalize!
    if type == 'Passenger'
      puts 'Enter its number'
      number = gets.chomp
      trains[number] = PassengerTrain.new(number)
    end
    if type == 'Cargo'
      puts 'Enter its number'
      number = gets.chomp
      trains[number] = CargoTrain.new(number)
    end
  when 'Trains'
    trains.each_key { |number| puts "Type:#{trains[number].type} Number:#{number} Wagons:#{trains[number].num_of_wagons}" }
  when 'New route'
    puts 'Enter route id'
    route_id = gets.chomp
    puts 'Enter first station'
    first = gets.chomp.capitalize
    puts 'Enter last station'
    last = gets.chomp.capitalize
    routes[route_id] = Route.new(route_id, stations[first], stations[last])
  when 'Routes'
    routes.each_key { |id| print "#{id}: First - #{routes[id].stations.first.name} Last - #{routes[id].stations.last.name}" }
  when 'Modify route'
    puts 'Enter route id'
    id = gets.chomp
    puts 'Enter Add or Remove to add or remove a station'
    command = gets.chomp.capitalize!
    puts 'Enter station'
    station = gets.chomp.capitalize
    case command
    when 'Add'
      routes[id].add_station(stations[station])
    when 'Remove'
      routes[id].remove_station(stations[station])
    end
  when 'Set train on route'
    puts 'Enter train number'
    train_number = gets.chomp
    puts 'Enter route id'
    route_id = gets.chomp
    trains[train_number].add_route(routes[route_id]) if routes[route_id] && trains[train_number]
  when 'Move forward'
    puts 'Enter train number'
    train_number = gets.chomp
    if trains[train_number]
      trains[train_number].move_forward
      puts "Current: #{trains[train_number].current_station.name}"
      puts "Previous: #{trains[train_number].previous_station.name if trains[train_number].previous_station.instance_of?(Station)}"
      puts "Next: #{trains[train_number].next_station.name if trains[train_number].next_station.instance_of?(Station)}"
      puts "Cargo trains on #{trains[train_number].current_station.name}: #{trains[train_number].current_station.types[:cargo]}"
      puts "Passenger trains on #{trains[train_number].current_station.name}: #{trains[train_number].current_station.types[:passenger]}"
    end
  when 'Move back'
    puts 'Enter train number'
    train_number = gets.chomp
    if trains[train_number]
      trains[train_number].move_back
      puts "Current: #{trains[train_number].current_station.name}"
      puts "Previous: #{trains[train_number].previous_station.name if trains[train_number].previous_station.instance_of?(Station)}"
      puts "Next: #{trains[train_number].next_station.name if trains[train_number].next_station.instance_of?(Station)}"
      puts "Cargo trains on #{trains[train_number].current_station.name}: #{trains[train_number].current_station.types[:cargo]}"
      puts "Passenger trains on #{trains[train_number].current_station.name}: #{trains[train_number].current_station.types[:passenger]}"
    end
  when 'Add wagon'
    puts 'Enter train number'
    number = gets.chomp
    if trains[number].instance_of?(PassengerTrain)
      trains[number].add_wagon(PassengerWagon.new)
    else
      trains[number].add_wagon(CargoWagon.new)
    end
  when 'Remove wagon'
    puts 'Enter train number'
    number = gets.chomp
    trains[number].remove_wagon
  when 'Stations on route'
    puts 'Enter route id'
    route_id = gets.chomp
    routes[route_id].print_stations
  when 'Stations'
    stations.each_key { |name| puts name.to_s}
  when 'Stop'
    break
  end
end
