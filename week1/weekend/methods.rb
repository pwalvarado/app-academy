class RockPaperScissors
  WINS = Hash[
    'rock', 'scissors',
    'scissors', 'paper',
    'paper', 'rock'
  ]

  def play
    player_move = nil
    until player_move == 'q'
      puts "rock, paper, or scissors? (q = quit)"
      player_move = gets.chomp
      computer_move = WINS.keys.sample
      if WINS[player_move] == computer_move
        puts "#{computer_move.capitalize}, Win"
      elsif player_move == computer_move
        puts "#{computer_move.capitalize}, Draw"
      else
        puts "#{computer_move.capitalize}, Lose"
      end
    end
  end
end

# rps = RockPaperScissors.new
# rps.play

def remix(drinks)
  random_alcohols = drinks.map { |drink| drink.first }.shuffle
  random_mixers = drinks.map { |drink| drink.last }.shuffle
  wonky_drinks = drinks
  until wonky_drinks & drinks == []
    wonky_drinks = random_alcohols.zip(random_mixers)
  end
  wonky_drinks
end

# p remix([
#   ["rum", "coke"],
#   ["gin", "tonic"],
#   ["scotch", "soda"]
# ])