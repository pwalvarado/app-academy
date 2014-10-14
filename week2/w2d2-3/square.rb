# encoding: utf-8
require './piece.rb'
require './sliding_piece.rb'
require './stepping_piece.rb'
require './king.rb'
require './queen.rb'
require './bishop.rb'
require './knight.rb'
require './rook.rb'
require './pawn.rb'

class Square
  attr_accessor :piece
  attr_reader :color
  
  def initialize(pos)
    @piece = nil
    @pos = pos
    @color = (pos[0] + pos[1]).even? ? :white : :black
  end
  
  def to_s
    piece.nil? ? "-" : piece.to_s
  end
end
