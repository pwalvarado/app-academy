require 'hand'

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
    
    it 'puts the dropped cards in the discard pile'
    
    it 'draws new cards from the deck' do
      allow(deck_double).to receive(:take_cards).with(2).and_return([card6, card7])
      hand.instance_variable_set(:@deck, deck_double)
      hand.exchange([0, 4])
      expect(hand.cards).to include(card6, card7)
    end
  end
  
  describe "#value" do
    it 'correctly values a high card' do
      card.rank = :
      expect().
    end
    it 'correctly values a pair' do
    end
    it 'correctly values a two pair' do
    end
    it 'correctly values a triple' do
    end
    it 'correctly values a straight' do
    end
    it 'correctly values a flush' do
    end
    it 'correctly values a full house' do
    end
    it 'correctly values a four of a kind' do
    end
    it 'correctly values a straight flush' do
    end
  end

end