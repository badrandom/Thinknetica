# frozen_string_literal: true

require_relative 'producers'

class Wagon
  include Producers
  include InstanceCounter
  attr_reader :type
  attr_accessor :number

  def initialize(type, number)
    @type = type
    @number = number
    validate!
    register_instance
    # rescue Exception => e #убрал, тк в задании сказано убрать все puts. Исключение все равно будет выбрасываться, но не будет обработки
    # e.message
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise ArgumentError, "Type must be 'Cargo' or 'Passenger'" if @type != 'Cargo' && @type != 'Passenger'
  end
end

class CargoWagon < Wagon
  attr_reader :free_capacity, :busy_capacity

  def initialize(capacity_in_tons = CAPACITY_IN_TONS, number = 0)
    @capacity_in_tons = capacity_in_tons
    @free_capacity = capacity_in_tons
    @busy_capacity = 0
    super('Cargo', number)
  end

  def add_cargo(weight_in_tons)
    if free_capacity >= weight_in_tons
      @free_capacity -= weight_in_tons
      @busy_capacity += weight_in_tons
    else
      raise StandardError, 'Not enough free capacity'
    end
  end

  # Решил не оставлять пустые классы. 68 тонн - средняя вместимость грузового вагона
  CAPACITY_IN_TONS = 68
end

class PassengerWagon < Wagon
  attr_reader :free_seats, :busy_seats, :num_of_seats

  def initialize(num_of_seats = NUM_OF_SEATS, number = 0)
    @num_of_seats = num_of_seats
    @free_seats = num_of_seats
    @busy_seats = 0
    super('Passenger', number)
  end

  def take_a_seat
    if @free_seats.positive?
      @free_seats -= 1
      @busy_seats += 1
    else
      raise StandardError, 'Not enough free seats'
    end
  end

  # Судя по википедии, вместимость спального вагона - 18 мест.
  NUM_OF_SEATS = 18
end
