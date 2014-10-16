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
      white_non_attacks + white_attacks
    else
      black_non_attacks + black_attacks
    end
  end

  def white_non_attacks
    non_attacks = []
    non_attacks << [0, -1] if board.piece(pos, [0, -1]).nil?
    if row == 6
      non_attacks << [0, -2] if board.piece(pos, [0, -1]).nil? && board.piece(pos, [0, -2]).nil?
    end
    non_attacks
  end

  def black_non_attacks
    non_attacks = []
    non_attacks << [0, 1] if board.piece(pos, [0, 1]).nil?
    if row == 1
      non_attacks << [0, 2] if board.piece(pos, [0, 1]).nil? && board.piece(pos, [0, 2]).nil?
    end
    non_attacks
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
    color == :white ? "♟" : "♙"
  end
end