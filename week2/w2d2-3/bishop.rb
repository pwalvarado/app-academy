# encoding: utf-8
require './piece.rb'
require './sliding_piece.rb'

class Bishop < SlidingPiece
  
  def move_dirs
    [[-1, 1], 
    [1, -1],
    [-1, -1],
    [1, 1]]
  end
  
  def to_s
    color == :white ? "♗" : "♝"
  end
  
end