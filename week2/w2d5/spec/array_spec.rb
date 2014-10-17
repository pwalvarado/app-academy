Rspec.describe Array do
  subject(:uniq_array) { [1, 2, 1, 3, 3].my_uniq }
  describe "#my_uniq" do
    
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
end