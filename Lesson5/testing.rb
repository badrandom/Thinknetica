# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'


station1 = Station.new('First')
station2 = Station.new('Second')
station3 = Station.new('Third')
station4 = Station.new('Fourth')

route1 = Route.new('1', station1, station2)
route2 = Route.new('1', station3, station4)
cargo1 = CargoTrain.new('1')
cargo2 = CargoTrain.new('2')
passenger1 = PassengerTrain.new('3')
passenger2 = PassengerTrain.new('4')
passenger3 = PassengerTrain.new('5')
puts "There are #{Station.instances} stations"
puts "There are #{Route.instances} routes"
puts "There are #{CargoTrain.instances} cargo trains"
puts "There are #{PassengerTrain.instances} passenger trains"
