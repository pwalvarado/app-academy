require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require 'colorize'

class BadMoveError < RuntimeError
end

class Player
  attr_reader :id, :deck, :hand

  def initialize(id, deck)
    @id = id
    @deck = deck
    @hand = Hand.new(deck)
  end

  def play_turn(current_suit, current_rank)
    loop do
      puts "current suit is " + "#{current_suit}".on_red
      puts "current rank is " + "#{current_rank}".on_red
      puts 'your cards are:'
      puts hand.to_s
      puts 'which index do you want to play?'
      puts '(enter blank string to draw or p to pass)'
      case input = gets.chomp
      when ''
        puts 'drawing card'
        hand.add_cards(deck.take(1))
      when 'p' then return :pass
      else return hand.play(Integer(input))
      end
    end
  end

  def choose_suit
    puts "Which suit would you like it to be?"
    gets.chomp.to_sym
  end

  def out_of_cards?
    hand.empty?
  end
end