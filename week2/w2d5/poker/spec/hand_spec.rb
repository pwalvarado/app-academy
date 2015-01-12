require 'hand'
require 'spec_helper'

RSpec.describe Hand do
  subject(:hand) { Hand.new(Deck.new) }

  describe '#initialize' do
    it 'contains five cards' do
      expect(hand.cards.count).to eq(5)
    end
  end

  describe '#exchange' do
    let(:card1) { double("card1") }
    let(:card2) { double("card2") }
    let(:card3) { double("card3") }
    let(:card4) { double("card4") }
    let(:card5) { double("card5") }
    let(:card6) { double("card6") }
    let(:card7) { double("card7") }

    let(:deck_double) { double("deck_double") }

    before(:each) do
      hand.instance_variable_set(:@cards, [card1, card2, card3, card4, card5])
    end

    it 'drops specified cards from the hand' do
      hand.exchange([0, 2, 4])
      expect(hand.cards).not_to include(card1, card3, card5)
    end

    it 'keeps undropped cards in the hand' do
      hand.exchange([0, 2, 4])
      expect(hand.cards).to include(card2, card4)
    end

    it 'raises an error if more than three cards are dropped' do
      expect { hand.exchange([0, 2, 3, 4]) }.to raise_error('can only drop 3')
    end

    it 'raises an error if it tries to drop cards out of range' do
      expect { hand.exchange([3, 4, 5]) }.to raise_error('invalid index')
    end

    it 'draws new cards from the deck' do
      allow(deck_double).to receive(:take_cards).with(2)
                                                    .and_return([card6, card7])
      hand.instance_variable_set(:@deck, deck_double)
      hand.exchange([0, 4])
      expect(hand.cards).to include(card6, card7)
    end
  end

  describe "evaluates hand" do
    context 'high card' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('5h4d3c2dAs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:high_card)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:ace)
      end
    end

    context 'one pair' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('5h5d3c2dAs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:one_pair)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:five)
      end
    end

    context 'two pair' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('5h5d3c3dAs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:two_pair)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:five)
      end
    end

    context 'three of a kind' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('Kh4d4c4dAs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:three_of_a_kind)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:four)
      end
    end

    context 'straight' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('7h8d9cTdJs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:straight)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:jack)
      end
    end

    context 'flush' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('5h4h3h8hQh'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:flush)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:queen)
      end
    end

    context 'full house' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('ThTdTcAdAs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:full_house)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:ten)
      end
    end

    context 'four of a kind' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('5h5d5c5s7s'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:four_of_a_kind)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:five)
      end
    end

    context 'straight flush' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('6h5h7h8h9h'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:straight_flush)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:nine)
      end
    end

    context 'royal flush' do
      before(:each) do
        hand.instance_variable_set(:@cards, cards('AsJsQsKsTs'))
      end

      it 'identifies hand type' do
        expect(hand.type).to eq(:royal_flush)
      end

      it 'identifies hand rank' do
        expect(hand.rank).to eq(:ace)
      end
    end
  end

  describe 'comparing hands' do
    deck = Deck.new
    let(:hand1) { Hand.new(deck) }
    let(:hand2) { Hand.new(deck) }

    it 'compares correctly two high-cards' do
      hand1.instance_variable_set(:@cards, cards('3c2s7d8d5s'))
      hand2.instance_variable_set(:@cards, cards('3h2d7h8sQs'))
      expect(hand1 <=> hand2).to eq(-1)
    end

    it 'compares correctly high-card vs. one pair' do
      hand1.instance_variable_set(:@cards, cards('3c2s7d8dKs'))
      hand2.instance_variable_set(:@cards, cards('3h3d7h8sQs'))
      expect(hand1 <=> hand2).to eq(-1)
    end

    it 'compares correctly two-pair vs. high-card' do
      hand1.instance_variable_set(:@cards, cards('6c6s7d7h5s'))
      hand2.instance_variable_set(:@cards, cards('3h2d9h8sQs'))
      expect(hand1 <=> hand2).to eq(1)
    end

    it 'compares correctly straight vs. royal flush' do
      hand1.instance_variable_set(:@cards, cards('3c4c5c6c7c'))
      hand2.instance_variable_set(:@cards, cards('TsJsQsKsAs'))
      expect(hand1 <=> hand2).to eq(-1)
    end

    it 'compares correctly straight flush vs. one pair' do
      hand1.instance_variable_set(:@cards, cards('3c4c5c6c7c'))
      hand2.instance_variable_set(:@cards, cards('AcAd5s3dTh'))
      expect(hand1 <=> hand2).to eq(1)
    end

    it 'compares correctly full house vs. four of a kind' do
      hand1.instance_variable_set(:@cards, cards('AcAsAhKhKs'))
      hand2.instance_variable_set(:@cards, cards('2h2d2s2c3h'))
      expect(hand1 <=> hand2).to eq(-1)
    end

    it 'compares correctly two full houses' do
      hand1.instance_variable_set(:@cards, cards('3c3s3dTdTc'))
      hand2.instance_variable_set(:@cards, cards('9h9d9s2h2d'))
      expect(hand1 <=> hand2).to eq(-1)
    end

    it 'compares correctly two straights' do
      hand1.instance_variable_set(:@cards, cards('8d9dTdJdQd'))
      hand2.instance_variable_set(:@cards, cards('9sTsJsQsKs'))
      expect(hand1 <=> hand2).to eq(-1)
    end

    it 'compares correctly two two-pairs' do
      hand1.instance_variable_set(:@cards, cards('JcJsQcQs4s'))
      hand2.instance_variable_set(:@cards, cards('JdJhQhQd2s'))
      expect(hand1 <=> hand2).to eq(1)
    end

    it 'compares correctly two royal flushes' do
      hand1.instance_variable_set(:@cards, cards('TsJsQsKsAs'))
      hand2.instance_variable_set(:@cards, cards('TcJcQcKcAc'))
      expect(hand1 <=> hand2).to eq(0)
    end
  end
end
