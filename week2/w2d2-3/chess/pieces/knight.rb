# encoding: utf-8
require_relative './piece.rb'
require_relative './stepping_piece.rb'

class Knight < SteppingPiece
  
  def move_diffs
    [[2, 1], 
    [1, 2], 
    [2, -1], 
    [-1, 2], 
    [1, -2], 
    [-2, 1],
    [-2, -1],
    [-1, -2]]
  end
  
  def to_s
    color == :white ? "♞" : "♘"
  end
  
end