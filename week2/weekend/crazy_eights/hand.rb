require_relative 'card'
require_relative 'deck'

class Hand
  attr_reader :cards

  def initialize(deck)
    @cards = deck.take(5)
  end

  def add_cards(new_cards)
    cards.concat(new_cards)
  end

  def play(i)
    cards.delete_at(i)
  end

  def to_s
    cards.map(&:to_s).join(' ')
  end

  def empty?
    cards.empty?
  end
end