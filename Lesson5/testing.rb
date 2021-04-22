# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'


station1 = Station.new('First')
station2 = Station.new('Second')

route = Route.new('1', station1, station2)
cargo1 = CargoTrain.new('8ds-0F')
passenger1 = PassengerTrain.new('dsa-ds')
cargo_wagon1 = CargoWagon.new(60, 1)
cargo_wagon2 = CargoWagon.new(60, 2)
pas_wagon1 = PassengerWagon.new(100, 1)
pas_wagon2 = PassengerWagon.new(100, 2)
cargo1.add_wagon(cargo_wagon1)
cargo1.add_wagon(cargo_wagon2)
passenger1.add_wagon(pas_wagon1)
passenger1.add_wagon(pas_wagon2)
cargo1.add_route(route)
passenger1.add_route(route)
puts "There are #{Station.instances} stations"
puts "There are #{Route.instances} routes"
puts "There are #{CargoTrain.instances} cargo trains"
puts "There are #{PassengerTrain.instances} passenger trains"
puts "There are #{PassengerWagon.instances} passenger wagons"
puts "There are #{CargoWagon.instances} cargo wagons"
station1.each_train do |train|
  print "Train #{train.number}: "
  train.each_wagon { |wagon| print " #{wagon.type}"}
  puts
end