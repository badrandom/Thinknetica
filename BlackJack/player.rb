# frozen_string_literal: true

# Describes players

require_relative 'deck'
require_relative 'validation'

class Player
  include Validation
  attr_reader :name, :deck
  attr_accessor :bank

  def initialize
    @deck = PlayerDeck.new
    @bank = 100
  end

  def take_card_from(deck)
    validate!(:type, deck, Deck)
    @deck.add_card(deck.take_random_card)
  end

  def take_card(card)
    validate!(:type, card, Card)
    @deck.add_card(card)
  end

  def show_deck
    @deck.show
  end

  def take_two_cards(deck)
    2.times do
      take_card(deck.take_random_card)
    end
  end

  def bet
    @bank -= 10
    10
  end
end

class Dealer < Player
  attr_reader :opened_up

  def initialize
    super
    @name = 'Dealer'
    @opened_up = false
  end

  def open_up
    @opened_up = true
  end

  def close
    @opened_up = false
  end
end

class User < Player
  def initialize
    super
    puts 'What is your name?'
    name = gets.chop
    @name = name
  end
end
