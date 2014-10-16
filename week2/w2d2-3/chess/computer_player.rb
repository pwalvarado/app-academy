VALUE = {
  :queen => 9.0,
  :rook => 5.0,
  :bishop => 3.15,
  :knight => 3.0,
  :pawn => 1.0
}

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
    sorted_capturing_moves = capturing_moves.sort_by do |move|
      dest = move.last
      piece_type_to_capture = board[dest].class.to_s.downcase.to_sym
      VALUE[piece_type_to_capture]
    end
    return sorted_capturing_moves.last unless sorted_capturing_moves.empty?

    all_moves.sample
  end
end