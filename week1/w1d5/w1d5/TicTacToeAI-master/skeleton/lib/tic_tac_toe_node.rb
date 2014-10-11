require_relative 'tic_tac_toe'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    next_mover_mark = (mark == :x ? :o : :x)
    node = TicTacToeNode.new(game.board, next_mover_mark)
    node.children.each do |child|
      if child.winning_node?(game.turn)
        return child.prev_move_pos
      end
    end
    node.children.each do |child| 
      return child.prev_move_pos unless child.losing_node?(game.turn)
    end
    
    raise "unexpected result! you must be very good at tic-tac-toe"
  end
end

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent = (evaluator == :x ? :o : :x)
    if board.over?
      case board.winner
      when opponent then true
      when nil then false
      when evaluator then false
      end
    elsif @next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    elsif @next_mover_mark == opponent
      children.any? { |child| child.losing_node?(evaluator) }
    else
      raise "what??? this is good coding practice"
    end
  end

  def winning_node?(evaluator)
    binding.pry if self.board.rows == [[:x, :o, :x], [nil, nil, nil], [nil, nil, nil]]
    opponent = (evaluator == :x ? :o : :x)
    if board.over?
      case board.winner
      when opponent then false
      when nil then false
      when evaluator then true
      end
    elsif @next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    elsif @next_mover_mark == opponent
      children.all? { |child| child.winning_node?(evaluator) }
    else
      raise "what??? this is good coding practice"
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_next_mover_mark = (next_mover_mark == :x ? :o : :x)
    parent_mark = child_next_mover_mark
    children = []
    empty_boxes.each do |empty_box|
      child_board = board.dup
      child_board[empty_box] = parent_mark
      children << TicTacToeNode.new(child_board, child_next_mover_mark, empty_box)
    end
    children
  end

  def empty_boxes
    empty_boxes = []
    board.rows.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        empty_boxes << [row_i, col_i] if board[[row_i, col_i]].nil?
      end
    end
    empty_boxes
  end

end

empty_board_node = TicTacToeNode.new(Board.new, :x)
board = Board.new
mark = :x
node = TicTacToeNode.new(board, mark)
empty_board_node.board[[0,0]] = :o
empty_board_node.board[[0,1]] = :o
empty_board_node.board[[0,2]] = :o
empty_board_node.losing_node?(node)
test_board = Board.new

computer1 = SuperComputerPlayer.new
computer2 = SuperComputerPlayer.new
human = HumanPlayer.new('David')
game = TicTacToe.new(computer1, human).run
game.board[[0,0]] = :x
game.board[[0,1]] = :x
game.board[[1,0]] = :o
game.board[[1,1]] = :o
computer1.move(game, :x)