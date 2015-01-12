require 'deck'
require 'spec_helper'

RSpec.describe Deck do
  describe '#initialize' do
    subject(:deck) { Deck.new }

    it 'initializes with 52 cards' do
      expect(deck.count).to eq(52)
    end

    it 'initializes with unique cards' do
      expect(card_arrays(deck).uniq.count).to eq(52)
    end

    it 'shuffles on initialize' do
      deck1 = Deck.new
      deck2 = Deck.new
      expect(card_arrays(deck1)).not_to eq(card_arrays(deck2))
    end
  end

  describe '#take_cards' do
    subject(:deck) { Deck.new }
    it 'returns card objects' do
      expect(deck.take_cards(5).first).to be_a(Card)
    end

    context 'take_cards cards properly' do
      let(:card1) { double("card1") }
      let(:card2) { double("card2") }

      subject(:deck) { Deck.new }

      before(:each) do
        deck.instance_variable_set(:@cards, [card1, card2])
      end

      it 'returns an array of cards' do
        expect(deck.take_cards(1)).to be_an(Array)
      end

      it 'take_cardss cards from the top of the deck' do
        expect(deck.take_cards(1)).to eq([card2])
      end

      it 'returns the correct number of cards' do
        expect(deck.take_cards(2).count).to eq(2)
      end

      it 'decreases the number of cards in the deck' do
        expect{ deck.take_cards(2) }.to change{ deck.count }.by(-2)
      end
    end
  end

  describe '#return_cards' do

    let(:card1) { double("card1") }
    let(:card2) { double("card2") }
    let(:card3) { double("card3") }

    subject(:deck) { Deck.new }

    before(:each) do
      deck.instance_variable_set(:@cards, [card1, card2])
    end

    it 'adds the cards to the bottom of the deck' do
      deck.return_cards([card3])
      expect(deck.cards).to eq([card3, card1, card2])
    end

    it 'increases the count of cards in the deck' do
      expect{ deck.return_cards([card3]) }.to change{ deck.count }.by(1)
    end
  end
end
