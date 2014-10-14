# encoding: utf-8
require './piece.rb'
require './stepping_piece.rb'

class Pawn < SteppingPiece
  
  def move_diffs
    color == :black ? [0, 1] : [0, -1]
  end
  
  def to_s
    color == :white ? "♙" : "♟"
  end
  
end