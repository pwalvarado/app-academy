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
    else raise BadMoveError.new('either slide or jump')
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

  private

    def slide(dest)
      teleport(dest) if valid_slide?(dest)
    end

    def valid_slide?(dest)
      if !valid_slide_dys.include?( dy(dest) )
        raise BadMoveError.new("that piece isn't a king")
      end

      true
    end

    def jumps(dests)
      if !valid_jumps?(dests)
        raise BadMoveError.new('invalid jump sequence')
      end

      dests.each { |dest| jump(dest) }

    end

    def jump(dest)
      check_jump_validity(dest)
      board[ jumped_pos(pos, dest) ] = nil
      teleport(dest)
    end

    def valid_jumps?(dests)
      dests.each do |dest|
        last_dest 
      end

      true
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

      true
    end

    def valid_slide_dys
      case
      when black? && !king? then [1]
      when red? && !king? then [-1]
      when king? then [-1, 1]
      end
    end

    def valid_jump_dys
      case
      when black? && !king? then [2]
      when red? && !king? then [-2]
      when king? then [-2, 2]
      end
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