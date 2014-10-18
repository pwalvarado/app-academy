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
  
  def value
    # high_c? then 0
    # one_pair? then 20
    
  end
  
  def ranks
    @cards.map {|card| card.rank}.uniq
  end
  
  def suits
    @cards.map {|card| card.suit}.uniq
  end
  
  def consecutive?
    ranks.count == 5 && 
      Card::RANKS[cards.first.rank] + 4 == Card::RANKS[cards.last.rank]
  end
end