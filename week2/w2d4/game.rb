require './piece.rb'
require './board.rb'
require 'io/console'
require 'colorize'

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
        board.display
        play_turn
      end
      puts "Game over. #{board.winner} won!"
    end
  end

  def play_turn
    player_move_sequence = get_move_sequence
    make_move(player_move_sequence)
    promote_kings
  end

  def promote_kings
    board.promotables.each { |promotable_piece| promotable_piece.king = true }
  end

  def get_move_sequence
    puts "#{current_player}, it's your turn."
    input_move_sequence
  end

  def input_move_sequence
    moves = []
    until moves[-2] && moves[-1] && moves[-2] == moves[-1]
      moves << select_pos
    end
    moves[0..-2] # last move is a duplicate from 'locking in' the sequence
  end

  def make_move(move_sequence)
    pos1 = move_sequence[0]
    pos2 = move_sequence[1]
    dx = pos2[0] - pos1[0]
    dy = pos2[1] - pos1[1]
    if dx.abs == 1 && dy.abs == 1 && move_sequence.size == 2
      slide(move_sequence)
    else
      jumps(move_sequence)
    end
  end

  def move_piece(start, ending)
    piece = board[start]
    piece.pos = ending
    board[start] = nil
    board[ending] = piece
  end

  def slide(move_sequence)
    start, ending = move_sequence
    move_piece(start, ending)
  end

  def jumps(move_sequence)
    move_sequence.each_with_index do |jump_start, i|
      next if i == move_sequence.length - 1
      jump_end = move_sequence[i + 1]
      jump(jump_start, jump_end)
    end
  end

  def jump(jump_start, jump_end)
    board[ jumped_pos(jump_start, jump_end) ] = nil
    move_piece(jump_start, jump_end)
  end

  def jumped_pos(jump_start, jump_end)
    # average the start and end coordinates for both x and y
    [ (jump_start[0] + jump_end[0]) / 2,
        (jump_start[1] + jump_end[1]) / 2]
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
      board.display
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