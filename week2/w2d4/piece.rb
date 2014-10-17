$LOAD_PATH << '.'
require 'board'

class BadMoveError < RuntimeError
end

class Piece
  attr_accessor :pos, :king
  attr_reader :color, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @king = false
  end

  def move(dest_poss)
    check_move_is_diagonal(dest_poss.first)
    case move_type(dest_poss.first)
    when :slide then slide(dest_poss.first)
    when :jump then jumps(dest_poss)
    else raise BadMoveError.new('must slide or jump')
    end
    maybe_promote
  end

  def to_s
    base = case color
    when :black then ' b'
    when :red then ' r'
    end
    king? ? base.upcase : base
  end

  def has_move?
    has_jump? || has_slide?
  end

  def has_jump?
    valid_jump_dys.each do |jump_dy|
      [-2, 2].each do |jump_dx|
        if jump_allowed?(pos, [jump_dx, jump_dy])
          return true
        end
      end
    end

    false
  end

  private

    def slide(dest)
      teleport(dest) if valid_slide?(dest)
    end

    def valid_slide?(dest)
      if !valid_slide_dys.include?( dy(dest) )
        raise BadMoveError.new("that piece isn't a king")
      end
      if board.jump_available?(color)
        raise BadMoveError.new('must jump when possible')
      end

      true
    end

    def jumps(dests)
      if dests.count > 1 && !valid_jumps?(dests)
        raise BadMoveError.new('invalid jump sequence')
      end

      dests.each_with_index do |dest, i|
        jump(dest) if valid_jump?(dest)
        board.display
        sleep(0.7) unless i == dests.size - 1
      end
    end

    def jump(dest)
      board[ jumped_pos(pos, dest) ] = nil
      teleport(dest)
    end

    def valid_jumps?(dests)
      poss = [pos] + dests
      jump_pairs(poss).all? { |jump_pair| valid_jump_pair?(jump_pair) }
    end

    def jump_pairs(poss)
      poss.map.with_index do |pos, i|
        next if i == poss.size - 1
        [pos, poss[i + 1]]
      end[0...-1]
    end

    def valid_jump_pair?(jump_pair)
      start, ending = jump_pair.first, jump_pair.last
      dx = ending[0] - start[0]
      dy = ending[1] - start[1]
      jump_allowed?(start, [dx, dy])
    end

    def teleport(dest)
      start = pos
      self.pos = dest
      board[start] = nil
      board[dest] = self
    end

    def maybe_promote
      if ( row == 0 && color == :red ) || ( row == 7 && color == :black )
        self.king = true
      end
    end

    def valid_jump?(dest)
      jumped = jumped_piece(pos, dest)
      unless jumped
        raise BadMoveError.new("can't jump empty square")
      end
      if jumped.color == color
        raise BadMoveError.new("don't jump your own piece")
      end
      unless has_jump?
        raise BadMoveError.new("that's not a legal jump")
      end

      true
    end

    def jump_allowed?(pos, diff)
      dx, dy = diff
      new_pos = [pos[0] + dx, pos[1] + dy]
      valid_jump_dys.include?(dy) &&
          board.valid?(new_pos) &&
          board[new_pos].nil? &&
          board.piece(pos, [dx / 2, dy / 2]) &&
          board.piece(pos, [dx / 2, dy / 2]).color != color
    end

    def has_slide?
      valid_slide_dys.each do |dy|
        [-1, 1].each do |dx|
          return true if board.piece(pos, [dx, dy]).nil?
        end
      end

      false
    end

    def valid_slide_dys
      case
      when black? && !king? then [1]
      when red? && !king? then [-1]
      when king? then [-1, 1]
      end
    end

    def valid_jump_dys
      valid_slide_dys.map { |dy| dy * 2 }
    end

    def move_type(dest)
      ( dx(dest).abs == 1 && dy(dest).abs == 1 ) ? :slide : :jump
    end

    def jumped_pos(jump_start, jump_end)
      # average the start and end coordinates for both x and y
      [ (jump_start[0] + jump_end[0]) / 2,
          (jump_start[1] + jump_end[1]) / 2]
    end

    def jumped_piece(jump_start, jump_end)
      board[jumped_pos(jump_start, jump_end)]
    end

    def check_move_is_diagonal(dest)
      raise BadMoveError.new('move diagonally') if dx(dest).abs != dy(dest).abs
    end

    def king?
      king
    end

    def row
      pos[1]
    end

    def col
      pos[0]
    end

    def black?
      color == :black
    end

    def red?
      color == :red
    end

    def dy(dest)
      dest[1] - row
    end

    def dx(dest)
      dest[0] - col
    end
end