$LOAD_PATH << '.'
require 'piece'
require 'board'
require 'io/console'
require 'colorize'
require 'pry'

class InputError < RuntimeError
end

class Game
  attr_accessor :board, :turns
  attr_reader :players

  def initialize
    @board = Board.new
    @turns = [:red, :black]
  end

  def play
    catch :quit do
      until board.game_over? do
        board.display(current_player)
        play_turn
        change_turn
      end
      board.display
      display_winner_message
    end
  end

  def display_winner_message
    if board.winner
      puts "Game over. #{board.winner.capitalize} won!"
    else
      puts "It's a draw."
    end
  end

  def play_turn
    move_sequence = get_move_sequence    
    moving_piece = mover(move_sequence)
    check_basic_move_conditions(moving_piece, move_sequence.last)
    destinations = move_sequence.drop(1)
    moving_piece.move(destinations)
  rescue BadMoveError => e
    puts e.message
    retry
  end

  def check_basic_move_conditions(moving_piece, final_dest)
    if moving_piece.nil?
      raise BadMoveError.new("can't move empty square")
    end
    if moving_piece.color != current_player
      raise BadMoveError.new('move your own piece')
    end
    if !board[final_dest].nil?
      raise BadMoveError.new("can't move onto a piece")
    end
  end

  def mover(move_sequence)
    board[move_sequence.first]
  end

  def get_move_sequence
    moves = []
    until moves[-2] && moves[-1] && moves[-2] == moves[-1]
      moves << select_pos
    end
    moves[0..-2] # ignore last move (duplicate from 'locking in' the sequence)
  end

  def current_player
    turns.first
  end

  def change_turn
    turns.rotate!
  end

  def select_pos
    until [' ', 'q'].include?(input = get_input)
      move_cursor(cursor_diff(cursor_dir(input)))
      board.display(current_player)
    end
    throw :quit if input == 'q'

    board.cursor_pos
  end

  def get_input
    begin
      user_input = STDIN.getch
      unless ['c', 'h', 't', 'n', 'q', ' '].include?(user_input)
        raise InputError.new('Unexpected input.')
      end
    rescue InputError
      retry
    end
    user_input
  end

  def cursor_dir(user_input)
    case user_input
    when 'c' then :up
    when 't' then :down
    when 'h' then :left
    when 'n' then :right
    else raise InputError.new('Unexpected input.')
    end
  end

  def cursor_diff(dir)
    case dir
    when :up then [0, -1]
    when :down then [0, 1]
    when :right then [1, 0]
    when :left then [-1, 0]
    end
  end

  def move_cursor(diff)
    dx, dy = diff
    new_cursor_pos = [board.cursor_pos[0] + dx, board.cursor_pos[1] + dy]
    board.cursor_pos = new_cursor_pos if board.valid?(new_cursor_pos)
  end
end

game = Game.new
game.play