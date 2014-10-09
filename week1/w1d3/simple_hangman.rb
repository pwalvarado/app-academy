#!/usr/bin/env ruby

class Hangman
  attr_accessor :word, :current_guess, :guesses, :num_misses
  
  def initialize
    @word = secret_word
    @guesses = []
    @num_misses = 0
  end
  
  def secret_word
    words = File.readlines('dictionary.txt').map(&:chomp)
    words.sample
  end
  
  def get_guess
    puts "Guess a letter."
    self.current_guess = gets.chomp
    guesses << current_guess
  end
  
  def play
    until game_over?
      get_guess
      self.num_misses += 1 if incorrect_guess?
      puts display
    end
    puts end_of_game_message
  end
  
  def display
    unguessed_letters = Regexp.new("[^#{guesses.join}]")
    word.gsub(unguessed_letters, '_')
  end
  
  def game_over?
    win? || loss?
  end
  
  def win?
    word.split('') - guesses == []
  end
  
  def loss?
    num_misses == 10
  end
  
  def incorrect_guess?
    !word.include?(current_guess)
  end
  
  def end_of_game_message
    case
    when win? then "Wow! You have a great vocabulary and won the game!!"
    when loss? then "You lost... go read the dictionary."
    end
  end
end

game = Hangman.new
game.play












