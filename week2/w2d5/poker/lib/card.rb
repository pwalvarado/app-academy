class Card
  attr_reader :suit, :rank
  
  SUITS = [:heart, :club, :spade, :diamond]
  RANKS = { :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13,
    :ace => 14
  }

  def initialize(suit, rank)
    raise "Invalid suit!" unless SUITS.include?(suit)
    raise "Invalid rank!" unless RANKS.include?(rank)
    @suit = suit
    @rank = rank
  end

  def rank_value
    RANKS[rank]
  end
end