def rps(player_move)
  raise "invalid move" unless valid_move?(player_move)
  computer_move = %w{Scissors Paper Rock}.sample
  "#{computer_move}, #{match_outcome(player_move, computer_move)}"
end

def valid_move?(player_move)
  %w{Scissors Paper Rock}.include?(player_move)
end

def match_outcome(player_move, computer_move)
  case player_move
  when "Rock"
    return case computer_move
    when "Rock" then "Draw"
    when "Scissors" then "Win"
    when "Paper" then "Lose"
    end
  when "Paper"
    return case computer_move
    when "Rock" then "Win"
    when "Scissors" then "Lose"
    when "Paper" then "Draw"
    end
  when "Scissors"
    return case computer_move
    when "Rock" then "Lose"
    when "Scissors" then "Draw"
    when "Paper" then "Win"
    end
  end
end
#
# p rps("Rock") # => "Paper, Lose"
# p rps("Scissors") # => "Scissors, Draw"
# p rps("Scissors") # => "Paper, Win"

def remix(mixed_drinks)
  alcohols = mixed_drinks.map { |mixed_drink| mixed_drink.first }.shuffle!
  mixers = mixed_drinks.map { |mixed_drink| mixed_drink.last }.shuffle!
  
  remixed_drinks = []
  (0...alcohols.count).each do |i|
    remixed_drinks << [alcohols[i], mixers[i]]
  end
  
  remixed_drinks
end

# p remix([
#   ["rum", "coke"],
#   ["gin", "tonic"],
#   ["scotch", "soda"]
# ])