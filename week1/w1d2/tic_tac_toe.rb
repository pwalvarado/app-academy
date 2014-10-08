class Board
  attr_accessor :squares
  
  def initialize
    @squares = Array.new(3) { Array.new(3) { nil } }
  end
  
  def game_over?
    won? || draw?
  end
  
  def draw?
    squares.flatten.none? { |square| square.nil? }
  end
  
  def won?
    win_on?(rows) || win_on?(cols) || win_on?(diagonals)
  end
  
  def win_on?(lines)
    lines.each do |line|
      return true if !line.first.nil? && line.all? { |mark| mark == line.first }
    end
    
    false
  end
  
  def rows
    squares
  end
  
  def cols
    cols = Array.new(3) { Array.new(3) }

    3.times do |i|
      3.times do |j|
        cols[j][i] = squares[i][j]
      end
    end

    cols
  end
  
  def diagonals
    diagonals = []
    diagonals << [squares[0][0], squares[1][1], squares[2][2]]
    diagonals << [squares[0][2], squares[1][1], squares[2][0]]
    
    diagonals
  end
  
  def lines
    rows + cols + diagonals
  end
  
  def winner
    ['x','o'].select { |mark| lines.any? { |line| all?(line, mark) } }
  end
  
  def all?(line, mark)
    line.first == mark && line.all? { |mark| mark == mark }
  end
  
  def empty?(pos)
    row, col = pos
    
    squares[row][col].nil?
  end
  
  def place_mark(pos, mark)
    row, col = pos
    squares[row][col] = mark if empty?(pos)
  end
end

class Game
  attr_accessor :board, :current_player, :inactive_player
  
  def initialize(player1, player2)
    @board = Board.new
    @current_player = player1
    @inactive_player = player2
    @current_player.mark = 'x'
    @inactive_player.mark = 'o'
  end
  
  def play
    until board.game_over?
      display
      make_move(get_move)
      switch_player
    end
    puts "Game over"
    display
  end
  
  def display
    board.squares.each { |row| print "#{row}\n" }
  end
  
  def get_move
    current_player.get_move(self)
  end
  
  def make_move(move)
    board.place_mark(move, current_player.mark)
  end
  
  def switch_player
    self.current_player, self.inactive_player = inactive_player, current_player
  end
end

class HumanPlayer
  attr_accessor :mark
  
  def get_move(game)
    puts "Make your move, pick a row"
    row = Integer(gets.chomp)
    puts "which column?"
    col = Integer(gets.chomp)
    [row, col]
  end
end

class ComputerPlayer
  attr_accessor :mark
  
  def get_move(game)
    return winning_move(game) if winning_move(game)
    random_move(game.board)
  end
  
  def winning_move(game)
    board = Marshal.load( Marshal.dump(game.board.dup))
    
    (0..2).each do |row|
      (0..2).each do |col|
        move = [row, col]
        mark = game.current_player.mark
        board.place_mark(move, mark)
        return move if board.won?
        board.place_mark(move, nil)
      end
    end
    nil
  end
  
  def random_move(board)
    puts "I'm alive!"
    empty_squares = []
    (0..2).each do |row|
      (0..2).each do |col|
        empty_squares << [row, col] if board.squares[row][col].nil?
      end
    end
    empty_squares.sample
  end
end

jackass = ComputerPlayer.new
matt_and_david = HumanPlayer.new
game = Game.new(matt_and_david, jackass)
game.play