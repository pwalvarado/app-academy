def stock_picker(prices)
  (0...prices.size).to_a.combination(2).max_by do |buy, sell|
    prices[sell] - prices[buy]
  end
end