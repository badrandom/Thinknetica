# frozen_string_literal: true

# Describes a deck of cards

require_relative 'card'
require_relative 'validation'
class Deck
  include Validation
  attr_reader :cards, :sum

  def initialize
    @cards = []
    @sum = 0
  end

  def add_card(card)
    validate!(:type, card, Card)
    @cards << card
  end

  def size
    @cards.size
  end

  def take_random_card
    raise ArgumentError, 'Error: Deck is empty.' if cards.empty?

    card = cards[Random.new.rand(0...cards.size)]
    remove_card(card)
    card
  end

  def cards_left
    @cards.size
  end

  def show
    @cards.each(&:show)
    puts "Sum = #{@sum}"
  end

  def reset_deck
    @cards = []
    @sum = 0
  end

  protected

  def remove_card(card)
    validate!(:type, card, Card)
    @cards.delete(card)
  end

  def update_sum(card)
    @sum += if card.type.instance_of?(Integer)
              card.type
            elsif card.type == 'T'
              if @sum + 11 > 21
                1
              else
                11
              end
            else
              10
            end
  end

  def fulfill_deck
    suits = ['+', '<3', '^', '<>']
    card_types = *(2..10)
    card_types += %w[J Q K T]
    suits.each do |suit|
      card_types.each do |type|
        add_card(Card.new(type, suit))
      end
    end
  end
end

class GameDeck < Deck
  def initialize
    super
    fulfill_deck
  end
end

class PlayerDeck < Deck
  def add_card(card)
    super
    update_sum(card)
  end
end
