require 'rspec'
require 'towers'

RSpec.describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new }
  describe '#render' do
    it 'returns an array' do
      expect(game.render).to be_an(Array)
    end
    
    it 'returns an array of arrays' do
      expect(game.render.all? { |el| el.is_a?(Array) }).to be true
    end
  end
  
  describe '#move' do
    context 'basic move' do
      before(:each) do
        game.move(0,1)
      end
    
      it 'takes a disc out of source tower' do
        expect(game.towers[0]).not_to include(1)
      end
    
      it 'puts it on a destination tower' do
        expect(game.towers[1]).to include(1)
      end
    end
    
    context 'takes from empty tower' do
      it 'should raise an error' do
        expect { game.move(2,0) }.to raise_error("can't take from empty tower")
      end
    end
    
    context "source disk cannot be bigger than top destination disk" do
      it 'should raise an error' do
        game.move(0,1)
        expect { game.move(0,1) }.to raise_error("must place disks in order")
      end
    end
  end
  
  describe '#won?' do
    it 'returns false in initial state' do
      expect(game.won?).to be false
    end
    
    it 'returns false before reaching winning state' do
      game.move(0, 1)
      game.move(0, 2)
      game.move(1, 2)
      expect(game.won?).to be false
    end
    
    it 'returns true upon winning state' do
      game.towers = [[], [], [3, 2, 1]]
      expect(game.won?).to be true
    end
    
  end
end