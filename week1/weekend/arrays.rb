class Array
  def my_uniq
    uniques = []
    self.each do |item|
      uniques << item unless uniques.include?(item)
    end
    uniques
  end
end

# p [1, 2, 1, 3, 3].my_uniq

class Array
  def two_sum
    two_sums = []
    self.each_with_index do |val1, i|
      (i+1...length).each do |j|
        two_sums << [i, j] if self[i] + self[j] == 0
      end
    end
    two_sums
  end
end

# p [-1, 0, 2, -2, 1].two_sum

class TowersOfHanoi
  attr_reader :towers

  def initialize
    @towers = [[3,2,1],[],[]]
  end

  def play
    until towers[1] == [3,2,1] || towers[2] == [3,2,1]
      display
      puts "take from which tower?"
      source = Integer(gets.chomp)
      puts "put on which tower?"
      dest = Integer(gets.chomp)
      make_move(source, dest)
    end
    puts "You won!"
    display
  end

  def make_move(source, dest)
    towers[dest].push(towers[source].pop)
  end

  def display
    towers.size.times do |tower_num|
      p towers[tower_num]
    end
  end
end

# game = TowersOfHanoi.new
# game.play

def my_transpose(matrix)
  size = matrix.size
  transposed = Array.new(size) { Array.new }
  size.times do |row_i|
    size.times do |col_i|
      transposed[col_i][row_i] = matrix[row_i][col_i]
    end
  end

  transposed
end

# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]
# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]
# p my_transpose(cols)
# p my_transpose(rows)

def stock_picker(prices)
  buy_sell_pairs = (0...prices.size).to_a.permutation(2).select do |buy_sell|
    buy_sell.first < buy_sell.last
  end
  buy_sell_pairs.max_by { |pair| prices[pair.last] - prices[pair.first] }
end

# p stock_picker([5,9,3,10,2,8])