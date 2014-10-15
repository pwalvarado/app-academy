class ComputerPlayer
  attr_accessor :name, :color, :board

  def set_name(player_number)
    %w{DeepBlue Watson Macbook AbacusII}.sample
  end

  def move
    piece = board.team_pieces(color).sample
    dest = piece.valid_moves.sample
    [piece.pos, dest]
  end
end