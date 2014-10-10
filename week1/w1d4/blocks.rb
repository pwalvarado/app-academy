class Array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
  end
  
  def my_map
    new_array = []
    self.my_each do |el|
      new_array << yield(el)
    end
    new_array
  end
  
  def my_select
    new_array = []
    self.my_each do |el|
      new_array << el if yield(el)
    end
    new_array
  end
  
  def my_inject
    accum = nil
    self.my_each do |el|
      if accum.nil?
        accum = el
        next
      end
      accum = yield(accum, el)
    end
    accum
  end

  def my_sort!
    sorted = false

    until sorted
      sorted = true
      self.length.times do |i|
        next if i == self.length - 1
        if yield(self[i], self[i+1]) == 1
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
      end
    end
    self
  end
  
  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end

def eval_block(*args)
  if block_given?
    yield(*args)
  else
    puts "NO BLOCK GIVEN"
  end
end