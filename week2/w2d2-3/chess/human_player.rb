class HumanPlayer
  attr_accessor :color, :board

  def move
    [board.select_pos, board.select_pos]
  end
end