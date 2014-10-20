require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::RANKS.keys.each do |rank|
      Card::SUITS.keys.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
    shuffle_cards
  end

  def shuffle_cards
    cards.shuffle!
  end

  def take(n)
    cards.pop(n)
  end

  def return(cards)
    cards.unshift(*cards)
  end
end