def range(start_point, end_point)
  return [] if end_point < start_point
  range(start_point, end_point - 1) + [end_point]
end

def sum_recursive(array)
  return array.first if array.length == 1
  array.last + sum_recursive(array[0...-1])
end

def sum_iterative(array)
  sum = 0
  array.each { |element| sum += element }
  sum
end

# 256 times if exp == 256
def power_slow(base, exp)
  return 1 if exp.zero?
  base * power_slow(base, exp - 1)
end

# approx 8 times if exp == 256
def power(base, exp)
  case
  when exp.zero? then 1
  when exp == 1 then base
  when exp.even? then power(base, exp / 2) * power(base, exp / 2)
  when exp.odd? then base * power(base, (exp - 1) / 2) * power(base, (exp - 1) / 2)
  end
end

class Array
  def deep_dup
    duped_array = []
    self.each do |el|
      if el.is_a?(Array)
        duped_array << el.deep_dup
      else
        duped_array << el
      end
    end
    duped_array
  end
end

def fib_rec(num)
  if num == 1
    [0]
  elsif num == 2
    [0, 1]
  else
    two_terms_previous = fib_rec(num - 2).last
    one_term_previous = fib_rec(num - 1).last
    next_term = two_terms_previous + one_term_previous
    fib_rec(num - 1) + [next_term]
  end
end

def fib_iter(num_of_fibs)
  fibs = [0, 1]
  until fibs.size == num_of_fibs
    fibs << fibs[-2] + fibs[-1]
  end
  fibs[0...num_of_fibs]
end

def bsearch(array, target)
  return nil if array.empty?
  sorted = array.sort
  middle_index = array.size / 2
  middle_value = sorted[middle_index]
  if target == middle_value
    middle_index
  elsif target < middle_value
    left_half = sorted[0...middle_index]
    bsearch(left_half, target)
  else
    right_half = sorted[middle_index + 1...array.size]
    bsearch(righ_half, target)
  end
end

module Change
  public
  def self.make_change(total, denoms)
    possible_combinations = combinations(total, denoms)
    possible_combinations.min_by { |combination| combination.size }
  end

  def self.combinations(total, denoms)
    return [[total]] if denoms.include?(total)
    all_combinations = []
    starting_denoms = starting_points(total, denoms)
    starting_denoms << denoms.last if starting_denoms.empty?
    starting_denoms.each do |denom|
      next if denom > total
      remaining = total - denom
      all_combinations += add_to_each(denom, combinations(remaining, denoms))
    end
    all_combinations
  end

  def self.add_to_each(num, arrays)
    arrays.map { |array| [num] + array }
  end
  
  def self.starting_points(total, denoms)
    denoms.select.with_index do |denom, i|
      if i == 0
        true
      else
        denoms[i - 1] < 2 * denoms[i]
      end
    end
  end
end

class Array
  def merge_sort
    if self.size == 0 || self.size == 1
      self
    else
      middle = self.length / 2
      sorted_left = self[0...middle].merge_sort
      sorted_right = self[middle...self.size].merge_sort
      merge(sorted_left, sorted_right)
    end
  end
  
  def merge(left, right)
    sorted_array = []
    until left.empty? || right.empty?
      if left.first < right.first
        sorted_array << left.shift
      else
        sorted_array << right.shift
      end
    end
    
    if left.empty?
      sorted_array += right
    else
      sorted_array += left
    end
    sorted_array
  end
end

# p [1, 6, 8, 9, 2, 3].merge_sort

class Array
  def subsets
    if self.empty?
      [self]
    elsif self.size == 1
      [[], self]
    else
      subs = []
      prior_values = self[0...self.size - 1]
      subs += prior_values.subsets + combine(self.last, prior_values.subsets)
      subs
    end
  end
  
  def combine(el, arrays)
    arrays.map { |array| array + [el] }
  end
end



















