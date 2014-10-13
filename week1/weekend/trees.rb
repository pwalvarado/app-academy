require 'pry'

class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    old_parent = @parent
    @parent = new_parent
    old_parent.children.delete(self) unless old_parent.nil?
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if children.include?(child_node)
      child_node.parent = nil
    else
      raise 'No such child.'
    end
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