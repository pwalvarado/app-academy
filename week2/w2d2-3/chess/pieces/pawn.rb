# encoding: utf-8
require_relative './piece.rb'
require_relative './stepping_piece.rb'

class Pawn < SteppingPiece
  attr_reader :board

  def initialize(board, pos, color)
    super(board, pos, color)
  end
  
  def move_diffs
    if color == :white
      [[0, -1]] + white_attacks
    else
      [[0, 1]] + black_attacks
    end
  end

  def white_attacks
    attacks = [[-1, -1], [1, -1]]
    attacks.select { |attack| !board.piece(pos, attack).nil? }
  end

  def black_attacks
    attacks = [[-1, 1], [1, 1]]
    attacks.select { |attack| !board.piece(pos, attack).nil? }
  end
  
  def to_s
    color == :white ? "♙" : "♟"
  end
  
end