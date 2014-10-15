# encoding: utf-8
require_relative './piece.rb'

class SlidingPiece < Piece
  attr_reader :board

  def initialize(board, pos, color)
    super(board, pos, color)
  end
  
  def moves
    almost_valid_moves = []
    move_dirs.each do |dir|
      almost_valid_moves += moves_in_dir(dir)
    end
    almost_valid_moves 
  end
  
  # def all_moves(dir)
  #   moves = []
  #   dir.each do |dir| # dir == [1,1]
  #     moves << moves_in_dir(dir)
  #   end
  #   moves
  # end
  #
  def moves_in_dir(dir)
    dir_moves = []
    dx, dy = dir
    base_x, base_y = pos
    x, y = base_x + dx, base_y + dy
    
    until offboard?(x ,y) || piece_hit?(x, y)
      dir_moves << [x, y]
      x += dx
      y += dy
    end
    
    dir_moves << [x, y] if valid_capture?(x, y)
    dir_moves
  end

  def valid_capture?(x, y)
    !offboard?(x, y) && board[[x, y]] && board[[x, y]].color != color
  end
  
  def piece_hit?(x, y)
    !!board[[x, y]]# ? true : false
  end
  
  def offboard?(x, y)
    [x, y].any? {|i| i < 0 || i > 7}
  end
end