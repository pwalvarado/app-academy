# encoding: utf-8
require './pieces.rb'
require 'io/console'
require 'colorize'

class IllegalMoveError < RuntimeError
end

class Board
  attr_accessor :pieces, :captured_pieces
  
  def initialize(blank = false)
    @pieces = Array.new(8) { Array.new(8) }
    set_board unless blank
  end

  def move(source_pos, dest_pos)
    if self[source_pos].nil?
      raise IllegalMoveError.new('There is no piece to move on that square.')
    elsif !self[source_pos].valid_moves.include?(dest_pos)
      raise IllegalMoveError.new('That move puts you in check.') if self[source_pos].moves.include?(dest_pos)
      raise IllegalMoveError.new('Not a valid move destination.')
    else
      move!(source_pos, dest_pos)
    end
  end

  def move!(source_pos, dest_pos)
    piece = self[source_pos]
    piece.move(dest_pos)
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

  def deep_dup
    dup_board = Board.new(true)
    pieces.flatten.compact.each do |piece|
      dup_pos = piece.pos.dup
      piece_type = piece.class
      dup_board[dup_pos] = piece_type.new(dup_board, dup_pos, piece.color)
    end
    dup_board
  end

  def in_check?(color)
    king = find_king(color)
    team_pieces(opp_color(color)).any? { |piece| piece.moves.include?(king.pos) }
  end

  def checkmate?(color)
    team_pieces(color).all? { |piece| piece.valid_moves.empty? }
  end

  def opp_color(color)
    color == :white ? :black : :white
  end

  def team_pieces(color)
    pieces.flatten.compact.select { |piece| piece.color == color }
  end

  def find_pieces(type, color)
    team_pieces(color).select { |piece| piece.is_a?(type) }
  end

  def find_king(color)
    team_pieces(color).find { |piece| piece.is_a?(King) }
  end
  
  def set_board
    # black power row
    self[[0, 0]] = Rook.new(self, [0, 0], :black)
    self[[1, 0]] = Knight.new(self, [1, 0], :black)
    self[[2, 0]] = Bishop.new(self, [2, 0], :black)
    self[[3, 0]] = Queen.new(self, [3, 0], :black)
    self[[4, 0]] = King.new(self, [4, 0], :black)
    self[[5, 0]] = Bishop.new(self, [5, 0], :black)
    self[[6, 0]] = Knight.new(self, [6, 0], :black)
    self[[7, 0]] = Rook.new(self, [7, 0], :black)
    # black pawns
    8.times do |pawn_col|
      self[[pawn_col, 1]] = Pawn.new(self, [pawn_col, 1], :black)
    end
      
    # white power row
    self[[0, 7]] = Rook.new(self, [0, 7], :white)
    self[[1, 7]] = Knight.new(self, [1, 7], :white)
    self[[2, 7]] = Bishop.new(self, [2, 7], :white)
    self[[3, 7]] = Queen.new(self, [3, 7], :white)
    self[[4, 7]] = King.new(self, [4, 7], :white)
    self[[5, 7]] = Bishop.new(self, [5, 7], :white)
    self[[6, 7]] = Knight.new(self, [6, 7], :white)
    self[[7, 7]] = Rook.new(self, [7, 7], :white)
    # white pawns
    8.times do |pawn_col|
      self[[pawn_col, 6]] = Pawn.new(self, [pawn_col, 6], :white)
    end
  end  
  
  def display(cursor_pos)
    system("clear")
    puts "   0 1 2 3 4 5 6 7"
    pieces.each_with_index do |row, row_i|
      puts "#{row_i}:" + row.map.with_index { |piece, col_i| print_square(piece, row_i, col_i, cursor_pos) }.to_a.join
    end
  end
  
  def print_square(piece, row_i, col_i, cursor_pos)
    square_char = piece.to_s == "" ? "  " : " #{piece.to_s}"
    if [col_i, row_i] == cursor_pos
      square_char.on_cyan
    else
      (row_i + col_i).even? ? square_char.on_blue : square_char
    end
  end
end