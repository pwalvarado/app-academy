# encoding: utf-8
require './piece.rb'

class SteppingPiece < Piece
  
  def moves
    moves = []
    move_diffs.each do |diff|
      next_move = move_with_diff(diff)
      moves << next_move unless next_move.nil?
    end
    moves 
  end
  
  def move_with_diff(diff)
    dx, dy = diff
    base_x, base_y = pos
    x, y = base_x + dx, base_y + dy
    [x, y] if valid_move?(x, y)
  end
  
  def valid_move?(x, y)
    !(offboard?(x, y) || (piece_hit?(x, y) && board[[x, y]].color == color))
  end
  
  def piece_hit?(x, y)
    board[[x, y]] ? true : false
  end
  
  def offboard?(x, y)
    [x, y].any? {|i| i < 0 || i > 7}
  end
end