# encoding: utf-8
require './piece.rb'
require './stepping_piece.rb'

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
    color == :white ? "♘" : "♞"
  end
  
end