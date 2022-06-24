# frozen_string_literal: true

# Describes game rules and controls the game

require_relative 'deck'
require_relative 'card'
require_relative 'player'

class Game
  def initialize
    @dealer = Dealer.new
    @user = User.new
    @deck = GameDeck.new
    @game_bank = 0
  end

  def start
    @dealer.close
    @game_bank = 0
    @dealer.deck.reset_deck
    @user.deck.reset_deck
    @dealer.take_two_cards(@deck)
    @user.take_two_cards(@deck)
    @game_bank += @dealer.bet
    @game_bank += @user.bet
    users_turn
  end

  private

  def dealers_turn
    @dealer.take_card_from(@deck) if @dealer.deck.sum < 17 && @dealer.deck.size < 3
    choose_next_turn('user')
  end

  def users_turn
    draw_field
    interface
    begin
      command = gets.chop
      case command
      when '1'
        dealers_turn
      when '2'
        take_card
        choose_next_turn('dealer')
      when '3'
        score
      else
        raise ArgumentError, 'Error: Wrong command.'
      end
    rescue ArgumentError => e
      puts e.message
      retry
    end
  end

  def choose_next_turn(next_player)
    if @user.deck.size >= 3 && @dealer.deck.size >= 3
      puts 'Both players reached 3 cards'
      score
    else
      send("#{next_player}s_turn")
    end
  end

  def take_card
    if @user.deck.size < 3
      @user.take_card_from(@deck)
    else
      puts 'You cannot take more cards!'
    end
  end

  def interface
    puts 'Your turn'
    puts '1 - Skip'
    puts '2 - Add card'
    puts '3 - Open up'
  end

  def score
    @dealer.open_up
    user_sum = @user.deck.sum
    dealer_sum = @dealer.deck.sum
    draw_field
    if user_sum > 21 && dealer_sum > 21
      puts 'Draw!'
      @dealer.bank += 10
      @user.bank += 10
    elsif user_sum > 21 || (user_sum < dealer_sum && dealer_sum <= 21)
      puts 'You lost!'
      @dealer.bank += @game_bank
    else
      puts 'You win!'
      @user.bank += @game_bank
    end
    ask_continue
  end

  def ask_continue
    puts "If you want to continue, enter 'Y', else enter 'N'"
    command = gets.chop.capitalize
    case command
    when 'Y'
      start
    when 'N'
      puts 'The game is finished'
    end
  end

  def draw_field
    system('cls')
    puts "Game bank: #{@game_bank}"
    puts "Dealer's bank: #{@dealer.bank}"
    puts "Your bank: #{@user.bank}"
    puts 'Your deck:'
    @user.show_deck
    puts "Dealer's deck: "
    @dealer.show_deck if @dealer.opened_up
  end
end
