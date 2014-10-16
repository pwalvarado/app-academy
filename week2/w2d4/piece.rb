class Piece
  attr_accessor :pos, :king
  attr_reader :color

  def initialize(pos, color)
    @pos = pos
    @color = color
    @king = false
  end

  def king?
    king
  end

  def promote
    self.king = true
  end

  def to_s
    base = case color
    when :black then ' b'
    when :red then ' r'
    end
    king? ? base.upcase : base
  end

  def row
    pos[1]
  end

  def black?
    color == :black
  end

  def red?
    color == :red
  end
end