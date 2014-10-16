class ComputerPlayer
  attr_accessor :name, :color, :board

  def set_name(player_number)
    self.name = "#{%w{DeepBlue Watson Macbook AbacusII}.sample}#{player_number}"
  end

  def move
    sleep(1)
    all_moves = []
    board.team_pieces(color).each do |piece|
      piece.valid_moves.each do |move|
        all_moves << [piece.pos, move]
      end
    end
    capturing_moves = all_moves.select do |move|
      dest = move.last
      !board[dest].nil? && board[dest].color != self.color
    end
    return capturing_moves.sample unless capturing_moves.empty?
    
    all_moves.sample
  end
end