require 'rspec'
require 'stock'

RSpec.describe "#stock_picker" do
  describe 'basic case' do
    it "returns the correct days" do
      expect(stock_picker([2, 1, 10, 12])).to eq([1, 3])
    end
    it "returns the correct days(2)" do
      expect(stock_picker([2, 5, 1, 14])).to eq([2, 3])
    end
  end
end