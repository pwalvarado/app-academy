class PolyTreeNode

  attr_accessor :children, :value
  attr_reader :parent

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end
  
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

  def remove_child(child_node)
    raise "Node is not a child" unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if value == target
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
      return current_node if current_node.value == target
      queue += current_node.children
    end
    
    nil
  end
end