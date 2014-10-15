# encoding: utf-8
require_relative './piece.rb'
require_relative './sliding_piece.rb'

class Bishop < SlidingPiece
  
  def move_dirs
    [[-1, 1], 
    [1, -1],
    [-1, -1],
    [1, 1]]
  end
  
  def to_s
    color == :white ? "♝" : "♗"
  end
  
end