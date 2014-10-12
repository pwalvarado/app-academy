def range(start, ending)
  if ending < start
    []
  else
    range(start, ending - 1) << ending
  end
end

# p range(3,1)
# p range(3,3)
# p range(5,8)

def sum_rec(array)
  if array.empty?
    0
  else
    sum_rec(array[0..-2]) + array[-1]
  end
end

# p sum_rec([1,2,3,4])

def sum_iter(array)
  sum = 0
  array.each do |el|
    sum += el
  end
  sum
end

# p sum_iter([1,2,3,4])

def pow(base, exp)
  if exp.zero?
    1
  else
    pow(base, exp - 1) * base
  end
end

# p pow(2,0)
# p pow(2,1)
# p pow(2,5)

def pow_fast(base, exp)
  if exp.zero?
    1
  elsif exp.even?
    pow_fast(base, exp / 2) * pow_fast(base, exp / 2)
  else # exp.odd?
    base * pow_fast(base, exp / 2) * pow_fast(base, exp / 2)
  end
end

# p pow_fast(2,0)
# p pow_fast(2,1)
# p pow_fast(2,5)

class Array
  def deep_dup
    duped = []
    self.each do |el|
      if el.is_a?(Array)
        duped << el.deep_dup
      else
        duped << el
      end
    end
    duped
  end
end

# mixed_arr = [1, [2], [3, [4]]]
# duped = mixed_arr.deep_dup
# duped[2][1][0] += 5
# duped << 8
# p duped
# p mixed_arr

def fibs(count)
  if count == 1
    [0]
  elsif count == 2
    [0, 1]
  else
    prev = fibs(count - 1)
    prev << prev[-2] + prev[-1]
  end
end

# p fibs(1)
# p fibs(2)
# p fibs(8)

def bsearch(array, target)
  return nil if array.empty?
  mid_index = array.size / 2
  mid_value = array[mid_index]
  case  target <=> mid_value
  when -1
    left = array[0...mid_index]
    bsearch(left, target)
  when 0 then mid_index
  when 1
    right = array[mid_index + 1...array.size]
    bsearch(right, target).nil? ? nil : (mid_index + 1) + bsearch(right, target)
  end
end

# p bsearch([1,2,3,4,5],1)
# p bsearch([1,2,3,4,5],3)
# p bsearch([1,2,3,4,5],5)
# p bsearch([1,2,3,4,5],6)

def make_change(total, coins)
  # binding.pry
  return [] if total.zero?
  best_change = nil
  coins.each do |first_coin|
    next if total < first_coin
    using_coins = coins.select { |coin| coin <= first_coin }
    this_change = [first_coin] + make_change(total - first_coin, using_coins)
    if best_change.nil? || this_change.size < best_change.size
      best_change = this_change
    end
  end
  best_change
end

# p make_change(14, [10, 7, 1])

class Array
  def merge_sort
    return self if size < 2
    left = self[0...size / 2]
    right = self[size / 2...size]
    merge(left.merge_sort, right.merge_sort)
  end

  def merge(arr1, arr2)
    sorted = []
    until arr1.empty? || arr2.empty?
      if arr1.first < arr2.first
        sorted << arr1.shift
      else
        sorted << arr2.shift
      end
    end
    sorted.concat(arr1).concat(arr2)
    sorted
  end
end

# p [1,2,3,4,5].merge_sort
# p [4,3,5,1,2].merge_sort
# p [4,3,5,1].merge_sort
# p [5,4,3,2,1].merge_sort

def subsets(array)
  return [[]] if array.empty?
  last_item = array.last
  other_items = array[0...-1]
  subsets(other_items) + subsets(other_items).map { |subs| subs << last_item}
end

# p subsets([])
# p subsets([1])
# p subsets([1, 2])
# p subsets([1, 2, 3])