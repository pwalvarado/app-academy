require 'card'
require 'deck'

class Hand
  TYPES = [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :straight,
    :flush,
    :full_house,
    :four_of_a_kind,
    :straight_flush,
    :royal_flush
  ]

  attr_reader :cards, :deck
  attr_writer :rank
  
  def initialize(deck)
    @cards = deck.take_cards(5).sort_by { |card| Card::RANKS[card.rank] }
    @deck = deck
    @rank = nil
  end
  
  def exchange(indices)
    raise "can only drop 3" if indices.size > 3
    raise "invalid index" unless indices.all? { |idx| idx.between?(0,4)}
    cards.delete_if.with_index { |card, idx| indices.include?(idx) }
    cards.concat(deck.take_cards(indices.count))
  end

  def <=>(other_hand)
    # see if one hand has a better poker hand type
    type_comparison = ( TYPES.index(type) <=> TYPES.index(other_hand.type) )
    return type_comparison unless type_comparison == 0
    
    # see if one of the poker hands was made with higher ranking card(s)
    hand_ranks_comparison = (Card::RANKS[rank] <=> Card::RANKS[other_hand.rank])
    return hand_ranks_comparison unless hand_ranks_comparison == 0
    
    # compare all cards, highest rank to lowest
    sort_cards
    other_hand.sort_cards
    4.downto(0) do |card_index|
      card_rank_comparison =
        cards[card_index].rank_value <=> other_hand.cards[card_index].rank_value
      return card_rank_comparison unless card_rank_comparison == 0
    end

    0 # these hands are identical down to the suit (which is not comparable)
  end

  def type
    sort_cards
    return :high_card if !consecutive? && ranks.count == 5 && !same_suit?
    return :one_pair if frequencies == [1, 1, 1, 2]
    return :two_pair if frequencies == [1, 2, 2]
    return :three_of_a_kind if frequencies == [1, 1, 3]
    return :straight if consecutive? && !same_suit?
    return :flush if !consecutive? && same_suit?
    return :full_house if frequencies == [2, 3]
    return :four_of_a_kind if frequencies == [1, 4]
    return :straight_flush if consecutive? && same_suit? &&
                                                        cards.last.rank != :ace
    return :royal_flush if consecutive? && same_suit? && cards.last.rank == :ace
  end

  def rank
    sort_cards
    case type
    when :high_card
      cards.last.rank
    when :one_pair
      frequency_map.find { |rank, count| count == 2 }.first
    when :two_pair
      frequency_map.find_all { |rank, count| count == 2 }.last.first
    when :three_of_a_kind
      frequency_map.find { |rank, count| count == 3 }.first
    when :straight
      cards.last.rank
    when :flush
      cards.last.rank
    when :full_house
      frequency_map.find { |rank, count| count == 3 }.first
    when :four_of_a_kind
      frequency_map.find { |rank, count| count == 4 }.first
    when :straight_flush
      cards.last.rank
    when :royal_flush
      :ace
    end
  end

  def sort_cards
    @cards = cards.sort_by { |card| Card::RANKS[card.rank] }
  end

  def frequency_map
    frequency_hash = Hash.new(0)
    @cards.each do |card|
      frequency_hash[card.rank] += 1
    end
    frequency_hash.sort_by do |rank, count|
      Card::RANKS[rank]
    end.to_h
  end

  def frequencies
    frequency_map.values.sort
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

  def same_suit?
    suits.count == 1
  end
end