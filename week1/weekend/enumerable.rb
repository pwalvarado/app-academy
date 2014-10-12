def doubler(array)
  array.map { |num| num * 2 }
end

class Array
  def my_each(&blk)
    i = 0
    until i == self.size
      blk.call(self[i])
      i += 1
    end

    self
  end
end

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end

# p return_value

def median(array)
  sorted = array.sort
  size = array.size  
  if size.odd?
    sorted[size/2]
  else
    (sorted[size/2] + sorted[(size/2)-1])/2.0
  end
end

# p median([2,1,3])
# p median([2,1,4,3])

def concat(strings)
  strings.inject(:+)
end

p concat(%w{these are strings})