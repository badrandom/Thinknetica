# frozen_string_literal: true

class Station

  attr_reader :trains, :name

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
      if train.type == 'Passenger'
        types[:passenger] += 1
      else
        types[:cargo] += 1
      end
    end
    types
  end

end
