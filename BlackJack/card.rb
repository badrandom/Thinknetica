# frozen_string_literal: true

# Describes one card

class Card
  attr_reader :type, :suit, :value

  def initialize(type, suit)
    @type = type
    @suit = suit
  end

  def show
    puts "Suit = #{@suit}, Type = #{@type}"
  end
end
