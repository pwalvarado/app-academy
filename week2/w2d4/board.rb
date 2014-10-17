# encoding: utf-8
$LOAD_PATH << '.'

require 'piece'
require 'colorize'

class Board
  attr_accessor :pieces, :cursor_pos, :winner
  
  def initialize
    @pieces = initial_board
    @cursor_pos = [3, 5]
    @winner = nil
  end

  def initial_board
    Array.new(8) do |y|
      Array.new(8) do |x|
        start_piece([x, y])
      end
    end
  end

  def start_piece(pos)
    x, y = pos
    if y.between?(3, 4) || (x + y).odd?
      nil
    else
      color = case y
      when (0..2) then :black
      when (5..7) then :red
      end
      Piece.new(pos, color, self)
    end
  end

  def game_over?
    win? || draw?
  end

  def win?
    [:red, :black].each do |color|
      if team_pieces( opp_color(color) ).empty?
        self.winner = color
        return true
      elsif team_pieces( opp_color(color) ).none?(&:has_move?) &&
                team_pieces(color).any?(&:has_move?)
        self.winner = color
        return true
      end
    end

    false
  end

  def draw?
    [:red, :black].all? do |color|
      team_pieces(color).none?(&:has_move?)
    end
  end

  def [](pos)
    x = pos[0]
    y = pos[1]
    pieces[y][x]
  end
  
  def []=(pos, piece)
    x = pos[0]
    y = pos[1]
    pieces[y][x] = piece
  end

  def piece(old_pos, diff)
    x, y = old_pos
    dx, dy = diff
    new_pos = [x + dx, y + dy]
    self[new_pos]
  end

  def opp_color(color)
    color == :red ? :black : :red
  end

  def team_pieces(color)
    pieces.flatten.compact.select { |piece| piece.color == color }
  end

  def jump_available?(color)
    team_pieces(color).any?(&:has_jump?)
  end
  
  def display(current_player = nil)
    system("clear")
    pieces.each_with_index do |row, y|
      puts row.map.with_index { |square, x| print(square, [x, y]) }.join
    end
    puts "#{current_player}, it's your turn." if current_player
  end
  
  def print(square, pos)
    square_str = string(square)
    bckgrnd_color = color(square, pos)
    square_str.colorize( :background => bckgrnd_color)
  end

  def string(square)
    square.nil? ? '  ' : square.to_s
  end

  def color(square, pos)
    x, y = pos
    case
    when cursor_pos == pos then :magenta
    when (x + y).even? then :black
    when (x + y).odd? then :red
    end
  end

  def valid?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end
end