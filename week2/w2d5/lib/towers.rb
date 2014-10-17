class TowersOfHanoi
  attr_accessor :towers
  
  def initialize
    @towers = [[3, 2, 1], [], []]
  end
  
  def render
    towers
  end
  
  def move(source, dest)
    raise "can't take from empty tower" if towers[source].empty?
    unless towers[dest].last.nil?
      if towers[source].last > towers[dest].last
        raise "must place disks in order" 
      end
    end
    
    towers[dest].push(towers[source].pop)
  end
  
  def won?
    return true if towers == [[], [], [3, 2, 1]]
    
    false
  end
end