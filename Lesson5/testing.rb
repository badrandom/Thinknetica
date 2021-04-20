# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'


station1 = Station.new('First')
station2 = Station.new('Second')
station3 = Station.new('Third')
station4 = Station.new('Fourth')
station5 = Station.new(nil)
puts "station5 validness: #{station5.valid?}"
station6 = Station.new('')
puts "station6 validness: #{station6.valid?}"

route1 = Route.new('1', nil , nil)
puts "route1 validness: #{route1.valid?}"
route2 = Route.new('2', station3, station4)
puts "route2 validness: #{route2.valid?}"
cargo1 = CargoTrain.new('0d00F')
puts "cargo1 validness: #{cargo1.valid?}"
cargo2 = CargoTrain.new('2')
puts "cargo2 validness: #{cargo2.valid?}"
passenger1 = PassengerTrain.new('00003')
puts "passenger1 validness: #{passenger1.valid?}"
passenger2 = PassengerTrain.new('00004sas')
puts "passenger2 validness: #{passenger2.valid?}"
passenger3 = PassengerTrain.new('0005')
puts "passenger3 validness: #{passenger3.valid?}"
wagon1 = CargoWagon.new(60, 50)
puts "wagon1 validness: #{wagon1.valid?}"
wagon2 = CargoWagon.new(60, 3)
puts "wagon2 validness: #{wagon2.valid?}"
wagon3 = PassengerWagon.new(100, 50)
puts "wagon3 validness: #{wagon3.valid?}"
puts "There are #{Station.instances} stations"
puts "There are #{Route.instances} routes"
puts "There are #{CargoTrain.instances} cargo trains"
puts "There are #{PassengerTrain.instances} passenger trains"
puts "There are #{PassengerWagon.instances} passenger wagons"
puts "There are #{CargoWagon.instances} cargo wagons"