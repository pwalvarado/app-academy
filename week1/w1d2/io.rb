def guessing_game
  answer = rand(1..100)
  
  guess = nil
  guess_count = 0
  until guess == answer
    guess = get_guess
    guess_count += 1
    puts "#{response(answer, guess)} / Total Guesses: #{guess_count}"
  end
end

def get_guess
  loop do
    puts "Guess a number, 1 to 100"
    guess = Integer(gets.chomp)
    return guess if (1..100).include?(guess)
  end
end

def response(answer, guess)
  case
  when guess == answer then "Congratulations, you're the champ!"
  when guess < answer then "Too low"
  else "Too high"
  end
end

class RpnCalculator
  attr_reader :stack, :mode
  attr_accessor :file_tokens
  
  def initialize
    @stack = []

  end
  
  def push(number)
    stack << number
  end
  
  def pop_values
    b = stack.pop
    a = stack.pop
    [a, b]
  end
  
  def evaluate(operation)
    push(pop_values.inject(operation))
  end
  
  def tokenize(input)
    %w[+ - / *].include?(input) ? input.to_sym : Float(input)
  end
  
  def value
    stack.last
  end
  
  def parse_file(file_name)
    self.file_tokens = File.read(file_name).split
  end
  
  def get_input
    if mode == :live_input
      
    else
      
    end
  end
  
  def calculate
    loop do
      input = get_input
      break if input.nil?
      if input.is_a?(Symbol)
        evaluate(input)
      else
        push(input)
      end
      puts "#{stack} : #{value}"
    end
  end
end

rpn = RpnCalculator.new
rpn.calculate

if ARGV.empty?
  @mode = :live_input
  tokenize(gets.chomp)
else
  @mode = :file_input
  tokenize(file_tokens.shift) unless file_tokens.empty?
  @file_tokens = parse_file(ARGV.first)
end


def shuffle_file
  puts "Which file would you like to shuffle?"
  file_name = gets.chomp
  lines = File.read(file_name).split(/\n/).shuffle
  shuffled_file = File.new("#{file_name}-shuffled.txt", "w")
  shuffled_file.puts(lines.join("\n"))
  shuffled_file.close
end


  
  













