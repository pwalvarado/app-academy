# encoding: utf-8
require_relative './piece.rb'
require_relative './sliding_piece.rb'

class King < SteppingPiece
  
  def move_diffs
    [[1, 1], 
    [1, 0], 
    [1, -1], 
    [0, -1], 
    [-1, -1], 
    [-1, 0],
    [-1, 1],
    [0, 1]]
  end
  
  def to_s
    color == :white ? "♚" : "♔"
  end
end