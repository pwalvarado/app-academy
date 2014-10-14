# encoding: utf-8
require './piece.rb'

class SlidingPiece < Piece
  
  def moves
    moves = []
    move_dirs.each do |dir|
      moves += moves_in_dir(dir)
    end
    moves 
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
    
    dir_moves << [x, y] if board[[x, y]] && board[[x, y]].color != color
    dir_moves
  end
  
  def piece_hit?(x, y)
    !!board[[x, y]]# ? true : false
  end
  
  def offboard?(x, y)
    [x, y].any? {|i| i < 0 || i > 7}
  end
end