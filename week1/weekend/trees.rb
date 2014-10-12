require 'pry'

class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    old_parent = @parent
    @parent = parent
    unless parent.nil? || parent.children.include?(self)
      parent.children << self
      old_parent.children.delete(self) unless old_parent.nil?
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    children.include?(child_node) ?
      (child_node.parent = nil) : (raise 'No such child.')
  end

  def dfs(target)
    if value == target
      self
    else
      children.each do |child|
        child_result = child.dfs(target)
        return child_result if child_result
      end
      nil
    end
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue.concat(current_node.children)
    end
    nil
  end
end