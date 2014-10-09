#!/usr/bin/env ruby

class Game
  attr_accessor :guesses, :secret_code, :current_guess
  
  def initialize
    @guesses = 0
    @secret_code = Code.new
  end
  
  def play
    until game_over?
      self.current_guess = get_guess
      give_feedback
    end
    puts end_of_game_message
  end
  
  def get_guess
    puts "What's your guess? Ex.: RGBB"
    self.guesses += 1
    Code.parse(gets.chomp)
  end
  
  def give_feedback
    puts "Exact matches: #{current_guess.exact_matches(@secret_code)}"
    puts "Near matches: #{current_guess.near_matches(@secret_code)}"
  end
  
  def game_over?
    return false if current_guess.nil?
    win? || loss?
  end
  
  def win?
    current_guess.exact_matches(secret_code) == 4
  end
  
  def loss?
    guesses == 10
  end
  
  def end_of_game_message
    case
    when win? then "You guessed correctly, won the game!"
    when loss? then "You ran out of turns, you lost the game!"
    end
  end
end

class Code
  PEGS = %w{ R G B Y O P }
  
  def self.random
    peg_code = []
    4.times { peg_code << PEGS.sample }
    peg_code
  end
  
  def self.parse(input)
    peg_code = input.upcase.split('')
    Code.new(peg_code)
  end
  
  attr_accessor :pegs
  
  def initialize(peg_code = self.class.random)
    @pegs = peg_code
  end
  
  def [](index)
    pegs[index]
  end
  
  def exact_matches(other_code)
    exact_matches = 0
    pegs.each_index { |i| exact_matches += 1 if self[i] == other_code[i] }
    exact_matches
  end
  
  def exact_matches_for_color(other_code, color)
    exact_matches = 0
    pegs.each_index do |i|
      if self[i] == other_code[i] && self[i] == color
        exact_matches += 1
      end
    end
    exact_matches
  end
  
  def near_matches(other_code)
    near_match_count = 0
    PEGS.each do |peg_color|
      near_match_count += near_matches_for_color(other_code, peg_color)
    end
    near_match_count
  end
  
  def near_matches_for_color(other_code, peg_color)
    exact_matches_of_color = exact_matches_for_color(other_code, peg_color)
    code1_unexact_match_count = self.pegs.count(peg_color) - exact_matches_of_color
    code2_unexact_match_count = other_code.pegs.count(peg_color) - exact_matches_of_color
    [code1_unexact_match_count, code2_unexact_match_count].min
  end
end

game = Game.new
game.play
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    