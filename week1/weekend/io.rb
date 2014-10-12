#!/usr/bin/env ruby

class GuessingGame
  attr_accessor :secret_num

  def initialize
    @secret_num = rand(1..100)
  end

  def play
    guess = nil
    until guess == secret_num
      puts "Guess a number."
      guess = Integer(gets.chomp)
      puts response(guess)
    end
  end

  def response(guess)
    case
    when guess < secret_num then "That's too low."
    when guess > secret_num then "That's too high."
    when guess == secret_num then "You won!"
    end
  end
end

# game = GuessingGame.new
# game.play

class RPNCalculator
  attr_accessor :stack, :tokens

  def initialize
    @stack = []
    @tokens = ( ARGV.empty? ? nil : File.read(ARGV[0]).split("\n") )
  end

  def value(operation)
    a, b = last_two_vals
    case operation
    when :+ then a + b
    when :- then a - b
    when :* then a * b
    when :/ then a / b
    end
  end

  def last_two_vals
    b = stack.pop
    a = stack.pop
    [a, b]
  end

  def run
    puts "Enter to quit."
    loop do
      p stack
      input = next_input
      break if input.nil? || input == ""
      input = parse_input(input)
      if operator?(input)
        stack.push(value(input))
      else
        stack.push(input) 
      end
    end
  end

  def next_input
    if tokens.nil?
      gets.chomp
    else
      tokens.shift
    end
  end

  def parse_input(input)
    if %w{+ - * /}.include?(input)
      input.to_sym
    else
      Integer(input)
    end
  end

  def operator?(input)
    input.class == Symbol
  end
end

calc = RPNCalculator.new
calc.run

def shuffle_file
  puts 'Which file would you like to shuffle?'
  file_name = gets.chomp
  lines = File.read(file_name).split("\n")
  File.write("#{file_name}-shuffled", lines.shuffle.join("\n"))
  puts "Lines shuffled. Output at #{file_name}-shuffled."
end

# shuffle_file