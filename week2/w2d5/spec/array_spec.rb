require 'rspec'
require 'array'

RSpec.describe Array do
  describe "#my_uniq" do
    subject(:uniq_array) { [1, 2, 1, 3, 3].my_uniq }
    
    it 'returns an array' do
      expect(uniq_array).to be_an(Array)
    end
    
    it 'should contain all unique values' do
      expect(uniq_array).to include(1)
      expect(uniq_array).to include(2)
      expect(uniq_array).to include(3)
    end
    
    it 'should not contain any repeats' do
      expect(uniq_array.count(1)).to eq(1)
      expect(uniq_array.count(2)).to eq(1)
      expect(uniq_array.count(3)).to eq(1)
    end
    
    it "doesn't change the order of elements" do
      index1 = uniq_array.index(1)
      index2 = uniq_array.index(2)
      expect(index1).to be < index2
    end
  end
  
  describe "#two_sum" do
    subject(:target_array) { [-1, 0, 2, -2, 1] }
    
    it 'returns an array' do
      expect(target_array.two_sum).to be_an(Array)
    end
    
    context 'handles a basic case' do
      subject(:target_array) { [-1, 2, -2, 1] }
      
      it 'returns the correct index pairs' do
        expect(target_array.two_sum).to eq([[0, 3],[1, 2]])
      end
    end
    
    context "handles a case with zero" do
      subject(:target_array) { [-1, 2, 0, -2, 1] }
      
      it "doesn't double on zero" do
        expect(target_array.two_sum).not_to include([2, 2])
      end
    end
    
    context "handles no matches" do
      subject(:target_array) { [-1, 2, 0] }
      
      it 'returns empty array' do
        expect(target_array.two_sum).to eq([])
      end
    end
    
  end
end