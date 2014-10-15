# encoding: utf-8
require_relative './piece.rb'
require_relative './stepping_piece.rb'

class Pawn < SteppingPiece
  attr_reader :board

  def initialize(board, pos, color)
    super(board, pos, color)
  end
  
  def move_diffs
    color == :black ? [[0, 1]] : [[0, -1]]
  end
  
  def to_s
    color == :white ? "♙" : "♟"
  end
  
end