require './pieces.rb'
require './board.rb'
require 'io/console'
require 'colorize'
require 'pry'

class Game
  attr_accessor :board, :cursor_pos
  attr_reader :players

  def initialize
    @board = Board.new
    @cursor_pos = [4, 6]
    @players = [:white, :black]
  end
  
  def play
    until board.game_over? do
      board.display(cursor_pos, current_player)
      play_turn(current_player)
    end
    puts "Game over. #{board.winner} won!"
  end

  def current_player
    players.first
  end

  def change_turn
    players.rotate!
  end

  def play_turn(current_player)
    source_pos = select_pos
    dest_pos = select_pos
    board.move(source_pos, dest_pos, current_player)
    change_turn
  rescue IllegalMoveError => e
    board.display(cursor_pos, current_player)
    puts "#{e.class}: #{e.message}"
    retry
  end

  def cursor_dir(input)
    case input
    when 'c' then :up
    when 't' then :down
    when 'h' then :left
    when 'n' then :right
    when 'b' then :pry
    end
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
    until (input = STDIN.getch) == ' '
      move_cursor(cursor_dir(input))
      board.display(cursor_pos, current_player)
    end
    cursor_pos
  end
end

game = Game.new
game.play