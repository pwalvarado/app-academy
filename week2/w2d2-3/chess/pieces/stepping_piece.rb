# encoding: utf-8
require_relative './piece.rb'

class SteppingPiece < Piece
  attr_reader :board

  def initialize(board, pos, color)
    super(board, pos, color)
  end

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
    !(board.offboard?([x, y]) || (piece_hit?(x, y) && board[[x, y]].color == color))
  end
  
  def piece_hit?(x, y)
    board[[x, y]] ? true : false
  end
end