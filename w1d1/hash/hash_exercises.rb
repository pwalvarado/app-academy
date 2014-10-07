class MyHashSet
  attr_reader :store
  
  def initialize
    @store = Hash.new(false)
  end
  
  def insert(el)
    store[el] = true
  end
  
  def include?(el)
    store[el]
  end
  
  def delete(el)
    el_present = store[el]
    store.delete(el)
    el_present
  end
  
  def to_a
    store.keys
  end
  
  def union(set2)
    store.merge(set2.store)
  end
  
  def intersect(set2)
    store.select { |key, val| set2.store[key] } 
  end
  
  def minus(set2)
    store.reject { |key, val| set2.store[key] }
  end
  
  def to_s
    store.inspect
  end
end

set = MyHashSet.new
set.insert(0)
p set
p set.include?(0)
p set.delete(0)
p set.delete(2)
p set
set.insert(0)
p set.to_a

set1 = MyHashSet.new
set1.insert(1)
set1.insert(2)
set1.insert(3)

set2 = MyHashSet.new
set2.insert(2)
set2.insert(3)
set2.insert(4)
set2.insert(5)

p set1.union(set2)
p set1.intersect(set2)
p set1.minus(set2)
p set2.minus(set1)