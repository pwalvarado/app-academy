require 'deck'

class Hand
  attr_reader :cards, :deck
  
  def initialize(deck)
    @cards = deck.take_cards(5)
    @deck = deck
  end
  
  def exchange(indices)
    raise "can only drop 3" if indices.size > 3
    raise "invalid index" unless indices.all? { |idx| idx.between?(0,4)}
    cards.delete_if.with_index { |card, idx| indices.include?(idx) }
    cards.concat(deck.take_cards(indices.count))
    p cards
  end
  
end