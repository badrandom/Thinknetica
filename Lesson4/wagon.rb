# frozen_string_literal: true

class Wagon
  def initialize(mass_in_tons)
    @mass_in_tons = mass_in_tons
  end
end

class CargoWagon < Wagon
  def initialize(capacity_in_tons = CAPACITY_IN_TONS, mass_in_tons = MASS_IN_TONS)
    @capacity_in_tons = capacity_in_tons
    super(mass_in_tons)
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
    super(mass_in_tons)
  end

  private
  # Судя по википедии, вместимость спального вагона - 18 мест.
  NUM_OF_PLACES = 18
  # Масса такого вагона - не более 67 тонн
  MASS_IN_TONS = 67
end
