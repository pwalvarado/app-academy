class Card
  attr_reader :rank, :suit

  RANKS = Hash[
    :two, '2',
    :three, '3',
    :four, '4',
    :five, '5',
    :six, '6',
    :seven, '7',
    :eight, '8',
    :nine, '9',
    :ten, 'T',
    :jack, 'J',
    :queen, 'Q',
    :king, 'K',
    :ace, 'A'
  ]

  SUITS = Hash[:clubs, 'c', :diamonds, 'd', :hearts, 'h', :spades, 's']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    RANKS[rank] + SUITS[suit]
  end
end