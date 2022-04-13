require_relative 'card'
class Deck
  attr_reader :cards

  def initialize
    @cards = fulfill_deck
  end

  private

  def fulfill_deck
    cards = []
    suits = ['+', '<3', '^', '<>']
    card_types = *(2..10)
    card_types += %w(J Q K T)
    suits.each do |suit|
      card_types.each do |type|
        cards << Card.new(type, suit)
      end
    end
    cards
  end

  def types_values_hash
    card_types_hash = {}
    card_types = *(2..10)
    card_types += %w(J Q K T)
    card_types.each do |type|
      value = if type.instance_of?(Integer)
                type
              else
                10
              end
      card_types_hash[type.to_s] = value
    end
    card_types_hash
  end
end