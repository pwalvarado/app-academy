require 'card'

RSpec.describe Card do
  
  describe 'initializes with suit and rank' do
    
    it "initializes with valid suit and rank" do
      expect{ Card.new(:heart, :three) }.not_to raise_error
    end
    
    it "raises error if initialized with invalid suit" do
      expect{ Card.new(:banana, :three) }.to raise_error("Invalid suit!")
    end
    
    it "raises error if initialized with invalid rank" do
      expect{ Card.new(:heart, :kanye) }.to raise_error("Invalid rank!")
    end
  end
  
  describe 'has reader methods for suit and rank' do
    subject(:card) { Card.new(:heart, :three) }
    it "returns a card's rank" do
      expect( card.suit ).to eq(:heart)
    end

    it "returns a card's suit" do
      expect( card.rank ).to eq(:three)
    end
  end

  describe "doesn't allow changes to suit or rank" do
    subject(:card) { Card.new(:heart, :three) }
    it "doesn't allow changes to suit" do
      expect(card).not_to respond_to(:suit=)
    end
    
    it "doesn't allow changes to rank" do
      expect(card).not_to respond_to(:rank=)
    end
  end
end