class MyHashSet
  attr_accessor :store

  def initialize
    @store = Hash.new(false)
  end

  def insert(el)
    store[el] = true
  end

  def include?(el)
    @store[el]
  end

  def delete(el)
    return_val = store[el]
    store.delete(el)

    return_val
  end

  def to_a
    store.keys
  end

  def union(other)
    union = MyHashSet.new
    all_elements = self.to_a + other.to_a
    union.insert_array(all_elements)
    union
  end

  def intersect(other)
    intersection = MyHashSet.new
    intersection.insert_array(store.keys.select { |el, val| other.include?(el) })
    intersection
  end

  def insert_array(array)
    array.each do |el|
      self.insert(el)
    end

    self
  end

  def minus(other)
    difference = MyHashSet.new
    difference.insert_array(store.keys.reject { |el| other.include?(el) })
    difference
  end
end

my_set_1 = MyHashSet.new
my_set_2 = MyHashSet.new

my_set_1.insert(1)
my_set_1.insert(2)
my_set_1.insert(3)
my_set_1.insert(5)

my_set_2.insert(3)
my_set_2.insert(4)
my_set_2.insert(5)

p my_set_1.union(my_set_2)
p my_set_1.intersect(my_set_2)
p my_set_1.minus(my_set_2)