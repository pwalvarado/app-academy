require 'card'

class Deck
  attr_reader :cards
  
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.keys.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    shuffle!
  end
  
  def count
    cards.count
  end
  
  def shuffle!
    cards.shuffle!
  end
  
  def take_cards(num)
    cards.pop(num)
  end
  
  def return_cards(card_array)
    card_array.each do |card|
      cards.unshift(card)
    end
  end
end