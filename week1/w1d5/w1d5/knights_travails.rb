require './00_tree_node.rb'

class KnightPathFinder
  def self.valid_moves(pos)
    diffs = [
      [1, 2],
      [1, -2],
      [2, 1],
      [2, -1],
      [-1, 2],
      [-1, -2],
      [-2, 1],
      [-2, -1]
    ]       
    
    current_coords = pos.coords
    new_coords = diffs.map! { |diff| adjust_coords(current_coords, diff) }
    new_coords.select! { |new_coord| coords_on_board?(new_coord) }
    
    new_coords.map! { |new_coord| PolyTreeNode.new(new_coord) } 
  end
  
  def self.coords_on_board?(coords)
    x, y = coords
    x.between?(0, 7) && y.between?(0, 7)
  end
  
  def self.adjust_coords(start, diff)
    [start[0] + diff[0], start[1] + diff[1]]
  end
  
  attr_accessor :visited_positions, :start_pos


  def initialize(start_pos)
    @start_pos = PolyTreeNode.new(start_pos)
    @visited_positions = [@start_pos]
    build_move_tree
  end

  def [](coords)
    visited_positions.select { |pos| pos.coords == coords }.first
  end

  def new_move_positions(pos)
    new_move_positions = valid_unvisited_moves(pos)
    visited_positions.concat(new_move_positions)
    
    new_move_positions
  end

  def valid_unvisited_moves(pos) 
    self.class.valid_moves(pos).reject do |valid_move|
      visited_positions.include?(valid_move)
    end
  end

  def build_move_tree 
    queue = [start_pos]
    until queue.empty?
      current_pos = queue.shift
      new_moves = new_move_positions(current_pos)
      current_pos.add_children(new_moves)
      queue += new_moves
    end
  end
  
  def find_path(end_pos)
    visited_positions.select { |pos| pos.coords == end_pos }
  end
  
  def trace_path_back(end_pos)
    trace = []
    current_node = visited_positions.select { |pos| pos.coords == end_pos }.first
    until current_node == nil
      trace << current_node.parent.coords unless current_node.parent.nil?
      current_node = current_node.parent
    end
    trace.reverse!
    trace.push(end_pos)
    trace
  end


end

class PolyTreeNode

  attr_accessor :children, :coords
  attr_reader :parent

  def initialize(coords = nil)
    @coords = coords
    @parent = nil
    @children = []
  end

  
  def ==(other)
    return false if (self.nil? || other.class != PolyTreeNode)
    self.coords == other.coords
  end
  
  # def inspect
  #   p "Coords = #{coords}"
  # end
  
  def parent=(parent)
    return if @parent == parent
    old_parent = @parent
    @parent = parent
    parent.register_child(self) if parent
    old_parent.unregister_child(self) if old_parent
  end

  def register_child(node)
    children << node unless children.include?(node)
  end
  
  def unregister_child(node)
    children.delete(node)
  end

  def add_child(child_node)
    child_node.parent = self
  end
  
  def add_children(child_nodes)
    child_nodes.each { |child_node| child_node.parent = self }
  end

  def remove_child(child_node)
    raise "Node is not a child" unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if coords == target
    children.each do |child|
      child_result = child.dfs(target)
      return child_result if child_result
    end

    nil
  end
  
  def bfs(target)
    queue = []
    queue << self
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.coords == target
      queue += current_node.children
    end
    
    nil
  end
end

kpf = KnightPathFinder.new([0,0])
p kpf.trace_path_back([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.trace_path_back([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]