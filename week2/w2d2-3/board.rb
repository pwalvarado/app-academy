# encoding: utf-8
require './piece.rb'
require './square.rb'
require './sliding_piece.rb'
require './stepping_piece.rb'
require './king.rb'
require './queen.rb'
require './bishop.rb'
require './knight.rb'
require './rook.rb'
require './pawn.rb'

class Board
  attr_accessor :pieces, :captured_pieces
  
  def initialize
    @pieces = Array.new(8) { Array.new(8) }
    @captured_pieces = []
    set_board
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
      self[[pawn_col, 6]] = Pawn.new(self, [pawn_col, 1], :white)
    end
  end  
  
  def display
    puts "   0 1 2 3 4 5 6 7"
    pieces.each_with_index do |row, row_i|
      puts "#{row_i}:" + row.map { |piece| print_square(piece) }.join
    end
  end
  
  def print_square(piece)
    piece.to_s == "" ? "  " : " #{piece.to_s}"
  end
end

board = Board.new
board.display
binding.pry
