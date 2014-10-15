require './pieces.rb'
require './board.rb'
require 'io/console'
require 'colorize'

class Game
  attr_accessor :board, :cursor_pos

  def initialize
    @board = Board.new
    @cursor_pos = [4, 6]
  end
  
  def play
    until false do
      p 'playing'
      play_turn
    end
  end

  def play_turn
    p 'playing'
    puts 'a'
    puts 'b'
    board.display(cursor_pos)
    source_pos = select_pos
    dest_pos = select_pos
    board.move(source_pos, dest_pos)
    puts 'here'
    board.display(cursor_pos)
  end

  def cursor_dir(input)
    case input
    when 'c' then :up
    when 't' then :down
    when 'h' then :left
    when 'n' then :right 
    end
  end

  def move_cursor(dir)
    diff = case dir
    when :up then [0, -1]
    when :down then [0, 1]
    when :right then [1, 0]
    when :left then [-1, 0]
    end
    dx, dy = diff
    self.cursor_pos = [cursor_pos[0] + dx, cursor_pos[1] + dy]
  end

  def select_pos
    until (input = STDIN.getch) == ' '
      move_cursor(cursor_dir(input))
      board.display(cursor_pos)
    end
    cursor_pos
  end
end

game = Game.new
game.play