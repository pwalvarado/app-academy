# maze_solver.rb 

class MazeSolver
  attr_reader :maze

  def initialize(maze_filename)
    @maze = Maze.new(maze_filename)
  end

  def solve
    explorer = MazeExplorer.new(start_tile.pos, maze)
  end
end


class Maze
  attr_reader :maze_tiles

  def initialize(filename)
    maze_array = File.read(filename).split("\n").map { |line| line.split('') }
    @maze_tiles = tiles(maze_array)
  end

  def tiles(maze_array)
    maze_array.map.with_index do |row, row_i|
      row.map.with_index do |el, col_i|
        maze_tile.new(el, [col_i, row_i])
      end
    end
  end

  def start_tile
    maze_tiles.select { |tile| tile.start? }
  end
end

class MazeExplorer
  attr_accessor :pos
  attr_reader :orientations

  def initialize(pos, maze)
    @orientations = [:up, :left, :down, :right]
    @pos = pos
    @maze = maze
  end

  def explore
    if next_tile.clear?
      go_to(next_tile)
    else
      turn_right
    end
  end

  def next_tile
    x, y = pos
    dx, dy = pos_diff
    new_pos = [x + dx, y + dy]
    maze(new_pos)
  end

  def go_to(tile)
    pos = tile.pos
    tile.visit
  end

  def turn_right
    @orientations.rotate!
  end

  def pos_diff
    case orientation
    when :up then [0, -1]
    when :down then [0, 1]
    when :left then [-1, 0]
    when :right then [1, 0]
    end
  end
end

class MazeTile
  def initialize(value, pos)
    @start, @end, @wall, @clear = false, false, false, false
    @visited = false
    case value
    when 'S' then @start = true
    when 'E' then @end = true
    when '*' then @wall = true
    when ' ' then @clear = true
    end
    @pos = pos
  end

  def start?
    @start
  end

  def end?
    @end
  end

  def wall?
    @wall
  end

  def clear?
    @clear
  end
end

MazeSolver.new('maze1.txt').solve