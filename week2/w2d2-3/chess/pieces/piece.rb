# encoding: utf-8
class Piece
  attr_accessor :pos, :captured, :color
  
  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @color = color
    @captured = false
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
end