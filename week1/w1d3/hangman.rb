#!/usr/bin/env ruby

class Hangman
  attr_accessor :word_length, :current_guess, :current_correct_indices,
                :guesses, :num_misses, :current_display
  attr_reader :guessing_player, :checking_player

  def initialize(guessing_player, checking_player)
    @current_display = ''
    @guesses = []
    @num_misses = 0
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    setup_game
    tell_word_length
    until game_over?
      guess
      process_guess
      puts current_display
    end
    puts end_of_game_message
  end

  def process_guess
    self.current_correct_indices =
      checking_player.correct_indices(current_guess)
    update_display if correct_guess?
    update_incorrect_guesses if !correct_guess?
    guessing_player.learn_correct_indices(current_correct_indices)
  end

  def tell_word_length
    guessing_player.learn_word_length(word_length)
  end

  def guess
    self.current_guess = guessing_player.make_guess
    guesses << current_guess
  end

  def setup_game
    tell_players_to_get_ready
    set_word_length
    initialize_display
  end

  def set_word_length
    self.word_length = checking_player.my_word_length
  end

  def initialize_display
    self.current_display = '_' * word_length
  end

  def tell_players_to_get_ready
    checking_player.choose_word
    guessing_player.get_ready_to_guess
  end

  def update_display
    current_correct_indices.each { |i| current_display[i] = "#{current_guess}" }
  end

  def game_over?
    win? || loss?
  end

  def win?
    !current_display.include?('_')
  end

  def loss?
    num_misses == 10
  end

  def update_incorrect_guesses
    self.num_misses += 1
  end

  def correct_guess?
    !current_correct_indices.empty?
  end
  
  def end_of_game_message
    case
    when win? then "Wow! You have a great vocabulary and won the game!!"
    when loss? then "You lost... go read the dictionary."
    end
  end
end

class HumanPlayer
  def learn_word_length(length)
    puts "The world length is #{length}."
  end
  
  def choose_word
    puts "Think of a word."
  end
  
  def get_ready_to_guess
    puts "You will be the guesser."
  end
  
  def learn_correct_indices(current_correct_indices)
    if current_correct_indices.empty?
      puts "You guessed wrong."
    else
      puts "You guessed right at indices #{current_correct_indices}."
    end
  end
  
  def make_guess
    puts "Guess a letter (ex: d)."
    gets.chomp.downcase
  end
  
  def my_word_length
    puts "Give a word length (ex: 7)."
    Integer(gets.chomp)
  end
  
  def correct_indices(guess)
    puts "Is the letter #{guess} correct? If so, type the correct indices"
    puts "with a space in between each index. If not, leave blank."
    case (response = gets.chomp)
    when "" then return []
    else parse(response)
    end
  end
  
  def parse(response)
    response.split(" ").map { |index| Integer(index) }
  end
end

class ComputerPlayer
  attr_accessor :secret_word, :other_players_word_length, :unguessed_letters,
                  :dictionary, :last_guess, :correct_guesses
                  
  def initialize
    self.dictionary = File.readlines('dictionary.txt').map(&:chomp)
  end
    
  def learn_word_length(length)
    self.other_players_word_length = length
  end
  
  def get_ready_to_guess
    self.unguessed_letters = ('a'..'z').to_a
    self.correct_guesses = {}
  end
  
  def choose_word
    create_secret_word
  end
  
  def make_guess
    filter_dictionary
    self.last_guess = unguessed_smart_guess
    unguessed_letters.delete(last_guess)
  end
  
  def unguessed_smart_guess
    ordered_smart_guesses.each do |letter|
      return letter if unguessed_letters.include?(letter)
    end
  end
  
  def learn_correct_indices(current_correct_indices)
    current_correct_indices.each { |index| correct_guesses[index] = last_guess }
  end
  
  def filter_dictionary
    dictionary.select! { |word| word.length == other_players_word_length }
    dictionary.select! { |word| matches_known_letters?(word) }
  end
  
  def matches_known_letters?(word)
    correct_guesses.all? { |index, letter| word[index] == letter }
  end
  
  def ordered_smart_guesses
    ('a'..'z').to_a.sort_by { |letter| dictionary.join.count(letter) }.reverse
  end
  
  def my_word_length
    secret_word.length
  end
  
  def correct_indices(guess)
    (0...secret_word.length).to_a.select { |i| secret_word[i] == guess }
  end
  
  private
  
  def create_secret_word
    self.secret_word = dictionary.sample  
  end
end

game = Hangman.new(ComputerPlayer.new, ComputerPlayer.new)
game.play
