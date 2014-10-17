require 'rspec'
require 'transpose'

RSpec.describe '#my_transpose' do
  
  let(:rows) { [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
  }
  
  let(:cols) { [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
  }
  
  it 'transposes from rows to cols' do
    expect(my_transpose(rows)).to eq(cols)
  end
  
  it 'transposes from cols to rows' do
    expect(my_transpose(cols)).to eq(rows)
  end
end