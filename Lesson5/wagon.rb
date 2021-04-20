# frozen_string_literal: true
require_relative 'producers'

class Wagon
  include Producers
  include InstanceCounter
  attr_reader :type
  def initialize(mass_in_tons, type)
    @mass_in_tons = mass_in_tons
    @type = type
    validate!
    register_instance
    #rescue Exception => e #убрал, тк в задании сказано убрать все puts. Исключение все равно будет выбрасываться, но не будет обработки
    # e.message
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise ArgumentError, 'Mass in tons must be higher than 5' if @mass_in_tons < 5
    raise ArgumentError, "Type must be 'Cargo' or 'Passenger'" if @type != 'Cargo' && @type != 'Passenger'
  end

end

class CargoWagon < Wagon
  def initialize(capacity_in_tons = CAPACITY_IN_TONS, mass_in_tons = MASS_IN_TONS)
    @capacity_in_tons = capacity_in_tons
    super(mass_in_tons, 'Cargo')
  end

  private
  # Решил не оставлять пустые классы. 68 тонн - средняя вместимость грузового вагона
  CAPACITY_IN_TONS = 68
  # Масса такого вагона - 23 тонны.
  MASS_IN_TONS = 23
end

class PassengerWagon < Wagon
  def initialize(num_of_places = NUM_OF_PLACES, mass_in_tons = MASS_IN_TONS)
    @num_of_places = num_of_places
    super(mass_in_tons, 'Passenger')
  end

  private
  # Судя по википедии, вместимость спального вагона - 18 мест.
  NUM_OF_PLACES = 18
  # Масса такого вагона - не более 67 тонн
  MASS_IN_TONS = 67
end
