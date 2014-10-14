# encoding: UTF-8
require 'yaml'

class Tile
  attr_accessor :board, :pos, :bomb, :revealed, :flagged

  DIFFS = [[1, 1],
           [1, 0],
           [1, -1],
           [0, -1],
           [-1, -1],
           [-1, 0],
           [-1, 1],
           [0, 1]
  ]

  def neighbor_poses
    new_pos = DIFFS.map do |move|
      dx, dy = move[0], move[1]
      [pos[0] + dx, pos[1] + dy]
    end
    new_pos.select { |pos| Tile.valid_pos?(pos, board) }
  end

  def self.valid_pos?(pos, board)
    pos.all? { |coordinate| coordinate.between?(0,(board.size - 1)) }
  end

  def initialize(board, pos)
    @board, @pos = board, pos
    @bomb, @revealed, @flagged = false, false, false
  end

  def reveal
    return if flagged
    self.revealed = true
    reveal_neighbors if adj_bombs == 0 && !bomb
  end

  def reveal_neighbors
    neighbor_tiles.each { |neighbor| neighbor.reveal unless neighbor.revealed }
  end

  def adj_bombs
    neighbor_tiles.count { |tile| tile.bomb }
  end

  def neighbor_tiles
    neighbor_poses.map { |pos| board[pos] }
  end

  def set_flagged
    self.flagged = true
  end

  def set_bomb
    self.bomb = true
  end

  def to_s
    if revealed && !bomb
      return ' X ' if flagged
      return '   ' if adj_bombs == 0
      return " #{adj_bombs} " if adj_bombs != 0
    elsif revealed && bomb
      return ' ⚑ ' if flagged
      return ' ☀ ' if !flagged
    else
      return '░░░' if !flagged
      return ' ⚑ ' if flagged
    end
  end
end

class Board
  attr_reader :rows, :size, :num_bombs
  attr_accessor :time_elapsed, :session_start_time

  def initialize(size, num_bombs)
    @size, @num_bombs = size, num_bombs
    @rows = Array.new(size) { Array.new { [] } }
    @time_elapsed, @session_start_time = 0, Time.now
    initialize_tiles
    set_bombs
  end

  def [](pos)
    rows[pos[1]][pos[0]]
  end

  def initialize_tiles
    size.times do |x|
      size.times do |y|
        rows[y] << Tile.new(self, [x, y])
      end
    end
  end

  def set_bombs
    tiles.shuffle.sample(num_bombs).each { |tile| tile.set_bomb }
  end

  def display
    puts "Time: #{time_elapsed.round(2)} sec"
    puts display_string = "  " + (0...size).map { |col| "_#{col}_"}.join
    rows.map.with_index do |row, i|
       puts "#{i}|#{row.map(&:to_s).join}"
    end
  end

  def won?
    revealed_enough_tiles? && revealed_no_bombs?
  end

  def revealed_no_bombs?
    tiles.none? { |tile| tile.revealed && tile.bomb }
  end

  def revealed_enough_tiles?
    total_non_bombs = (size ** 2) - num_bombs
    tiles.count { |tile| tile.revealed } == total_non_bombs
  end

  def tiles
    rows.flatten
  end

  def lost?
    tiles.any? { |tile| tile.revealed && tile.bomb }
  end

  def reveal_all_bombs
    tiles.select { |tile| tile.bomb }.each { |bomb| bomb.reveal }
  end
  
  def update_time_elapsed
    self.time_elapsed += Time.now - session_start_time
  end
end

class Minesweeper
  attr_reader :board
  attr_accessor :leaderboard

  def initialize(size = 9, num_mines = 10)
    @board = setup_board(size, num_mines)
    @quit = false
  end

  def play
    initialize_start_time
    catch :quit do
      until game_over?
        board.display
        execute(command)
      end
      end_game_message
      board.display
      update_leaderboard if board.won?
      display_leaderboard
    end
  end
  
  def update_leaderboard
    puts "What's your name? You might be on the leaderboard."
    name = gets.chomp
    self.leaderboard = load_leaderboard
    leaderboard << [name, board.time_elapsed]
    open('leaderboard.dat','w') do |f|
      f.puts(leaderboard.to_yaml)
    end
  end

  def setup_board(size, num_mines)
    puts "Would you like to load a game? y or n"
    load_option = gets.chomp.downcase
    load_option == 'y' ? load_board : new_game(size, num_mines)
  end

  def load_board
    puts "What game file do you want to load?"
    filename = gets.chomp.downcase
    YAML.load(File.read(filename))
  end
  
  def initialize_start_time
    board.session_start_time = Time.now
  end

  def new_game(size, num_mines)
    Board.new(size, num_mines)
  end

  def game_over?
    board.won? || board.lost?
  end

  def make_move(move_instruction)
    pos = move_instruction[0]
    action = move_instruction[1]
    tile = board[pos]
    tile.send(action)
    board.update_time_elapsed
  end

  def command
    puts "Choose a tile, column then row. Ex.: 45 (to reveal) or f81 (to flag)"
    puts "Press q to quit. (You can save the game.)"
    gets.chomp
  end

  def execute(command)
    command[0] == 'q' ? quit : make_move(parse(command))
  end

  def parse(move_string)
    [pos(move_string), action(move_string)]
  end

  def pos(move_string)
    pos_string = move_string[/\d+/]
    [Integer(pos_string[0]), Integer(pos_string[1])]
  end

  def action(move_string)
    move_string[0] == 'f' ? :set_flagged : :reveal
  end

  def quit
    puts "Would you like to save the game? y or n"
    save = gets.chomp.downcase
    save_game if save == 'y'
    throw :quit
  end

  def save_game
    puts "Choose a filename."
    filename = gets.chomp.downcase
    board.update_time_elapsed
    File.open(filename, 'w') do |f|
      f.puts(board.to_yaml)
    end
  end

  def end_game_message
    if board.won?
      puts "You won the game! Nice work finding all of the mines!"
    else
      puts "You hit a mine! Think harder next time!"
      board.reveal_all_bombs
    end
  end
  
  def sorted_leaderboard
    load_leaderboard.sort! do |leaderboard_entry1, leaderboard_entry2|
      time1, time2 = leaderboard_entry1[1], leaderboard_entry2[1]
      time1 <=> time2
    end
  end
  
  def load_leaderboard
    begin
      leaderboard = YAML.load(File.read('leaderboard.dat'))
      leaderboard.is_a?(Array) ? leaderboard : []
    rescue Errno::ENOENT
      []
    end
  end
  
  def display_leaderboard
    puts "Leaderboard:".center(19)
    puts "(Top 3 Scores)".center(19)
    sorted_leaderboard.take(3).each do |leader, time|
      puts "#{leader.ljust(12)} #{time.round(2)} sec"
    end
  end
end

game = Minesweeper.new(9, 8)
game.play