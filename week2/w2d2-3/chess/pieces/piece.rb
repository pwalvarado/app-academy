# encoding: utf-8
require 'pry'

class Piece
  attr_accessor :pos, :color
  
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
  end
  
  def moves
    raise 'Not implemented yet'
  end

  def inspect
    "#{self.class} @ #{self.pos}"
  end

  def move(dest_pos)
    board[pos] = nil
    board[dest_pos] = self
    self.pos = dest_pos
  end

  def valid_moves
    moves.select do |move|
      !move_into_check?(move)
    end
  end

  def move_into_check?(dest_pos)
    dup_board = board.deep_dup
    dup_board.move!(pos.dup, dest_pos.dup)
    dup_board.in_check?(self.color)
  end

  def row
    pos[1]
  end
end