class Array
  def my_each(&blk)
    i = 0
    until i == size
      blk.call(self[i])
      i += 1
    end
  end

  def my_map(&blk)
    new_array = []
    my_each { |el| new_array << blk.call(el) }
    new_array
  end

  def my_select(&blk)
    new_array = []
    my_each { |el| new_array << el if blk.call(el) }
    new_array
  end
end

# [1,2,3,4].my_each { |x| puts x }
# p [1,2,3,4].my_map { |x| x * x }
# p [1,2,3,4].my_select { |x| x < 3 }

class Array
  def my_inject(&blk)
    accum = self[i]
    my_each.with_index do |el, i|
      next if i == 0
      accum = blk.call(accum, el)
    end
    accum
  end
end

# p [1, 2, 3].inject { |sum, num| sum + num }

class Array
  def my_sort(&blk)
    self.dup.my_sort!(&blk)
  end

  def my_sort!(&blk)
    sorted = false
    until sorted
      sorted = true
      each_index do |i|
        if blk.call(self[i], self[i+1]) == 1
          self[i], self[i+1] = self[i+1], self[i]
          sorted = false
        end
      end
    end  

    self    
  end
end

# p [1, 3, 5].my_sort! { |num1, num2| num1 <=> num2 } # sort ascending
# p [1, 3, 5].my_sort! { |num1, num2| num2 <=> num1 } # sort descending

# arr = [4,5,3,1,2]
# p arr.my_sort { |num1, num2| num2 <=> num1 }
# p arr

def eval_block(*args, &blk)
  if blk
    blk.call(*args)
  else
    puts 'NO BLOCK GIVEN!'
  end
end

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end