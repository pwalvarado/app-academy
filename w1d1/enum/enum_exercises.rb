def double(arr)
  arr.map { |el| el * 2 }
end

# p double([1, 2])

class Array
  def my_each
    i = 0
    while i < self.size
      yield(self[i])
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

def median(arr)
  size = arr.size
  arr.sort!
  size.odd? ? arr[size/2] : (arr[size/2 - 1] + arr[size/2])/2.0
end

# p median([2, 5, 4, 1, 3]) #3
# p median([2, 5, 4, 3]) #3.5

def concat(arr)
  arr.inject(:+)
end

p concat(["hi", "hello"])