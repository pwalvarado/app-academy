# encoding: utf-8
require_relative './piece.rb'
require_relative './sliding_piece.rb'

class Rook < SlidingPiece
  
  def move_dirs
    [[0, 1], 
    [1, 0], 
    [0, -1], 
    [-1, 0]] 
  end
  
  def to_s
    color == :white ? "♖" : "♜"
  end
end