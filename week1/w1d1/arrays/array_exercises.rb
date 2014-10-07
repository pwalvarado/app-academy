class Array
  def my_uniq
    uniq_array = []
    self.each {|item| uniq_array << item unless uniq_array.include?(item)}
    uniq_array
  end
  
  def two_sum
    result_arr = []
    (0...self.size).each do |i|
      (i+1...self.size).each do |j|
        result_arr << [i,j] if self[i] + self[j] == 0
      end
    end
    result_arr
  end
end

class Hanoi
  
  def initialize
    @towers = Hash[1, [3, 2, 1], 2, [],3 ,[]]
  end
  
  def play
    until @towers[2] == [3,2,1] || @towers[3] == [3,2,1]
      display
      get_move
    end
    display
    puts "YOU WON! :)"
  end
  
  def display
    puts "1: #{@towers[1]}"
    puts "2: #{@towers[2]}"
    puts "3: #{@towers[3]}"
  end
  
  def get_move
    source = nil 
    destination = nil
    current_disk = nil
    
    until [1,2,3].include?(source) && !@towers[source].empty?
      puts "Which tower do you want to remove the disk from?"
      source = gets.chomp.to_i
    end
    current_disk = @towers[source].pop
    until [1,2,3].include?(destination) &&
        (@towers[destination].empty? || @towers[destination].last > current_disk) 
      puts "Which tower do you want to add the disk to?"
      destination = gets.chomp.to_i
    end
    @towers[destination] << current_disk
  end
end

def my_transpose(matrix)
  new_matrix = Array.new(matrix.size) { Array.new } 
  matrix.each_with_index do |column, column_index|
    column.each_with_index do |item, row_index|
      new_matrix[row_index][column_index] = item
    end
  end
  new_matrix
end

def stock_picker(prices)
  buy_sell_pairs = (0...prices.size).to_a.combination(2)
  buy_sell_pairs.max_by { |buy, sell| prices[sell] - prices[buy] }
end

p stock_picker([4,10,20,2,50,40])