require './pieces.rb'
require './board.rb'
require './human_player.rb'
require 'io/console'
require 'colorize'
require 'pry'

class InputError < ArgumentError
end

class Game
  attr_accessor :board, :cursor_pos
  attr_reader :players

  def initialize(player1, player2)
    @board = Board.new
    @cursor_pos = [4, 6]
    @players = [player1, player2]
    assign_players_colors
    show_players_board
  end
  
  def play
    catch :quit do
      until board.game_over? do
        board.display(cursor_pos, current_player.color)
        play_turn
      end
      puts "Game over. #{board.winner} won!"
    end
    puts "Thanks for playing!"
  end

  def assign_players_colors
    players.first.color = :white
    players.last.color = :black
  end

  def show_players_board
    players.each { |player| player.board = self }
  end

  def current_player
    players.first
  end

  def change_turn
    players.rotate!
  end

  def play_turn
    source_pos, dest_pos = current_player.move
    board.move(source_pos, dest_pos, current_player.color)
    change_turn
  rescue IllegalMoveError => e
    board.display(cursor_pos, current_player.color)
    puts "#{e.class}: #{e.message}"
    retry
  end

  def cursor_dir(user_input)
    case user_input
    when 'c' then :up
    when 't' then :down
    when 'h' then :left
    when 'n' then :right
    when 'q' then throw :quit
    else raise InputError.new('Unexpected input.')
    end
  rescue InputError => e
    puts e.message
  end

  def move_cursor(dir)
    diff = case dir
    when :up then [0, -1]
    when :down then [0, 1]
    when :right then [1, 0]
    when :left then [-1, 0]
    when :pry
      binding.pry
      [0, 0]
    end
    dx, dy = diff
    self.cursor_pos = [cursor_pos[0] + dx, cursor_pos[1] + dy]
  end

  def select_pos
    until [' ', 'q'].include?(input = get_input)
      move_cursor(cursor_dir(input))
      board.display(cursor_pos, current_player.color)
    end
    throw :quit if input == 'q'

    cursor_pos
  end

  def get_input
    begin
      user_input = STDIN.getch
      unless ['c', 'h', 't', 'n', 'q', ' '].include?(user_input)
        raise InputError.new('Unexpected input.')
      end
    rescue InputError => e
      puts e.message
      retry
    end
    user_input
  end
end

david = HumanPlayer.new
eline = HumanPlayer.new
game = Game.new(david, eline)
game.play