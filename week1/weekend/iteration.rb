def factors(num)
  (1..num).each.to_a.select { |divisor| num % divisor == 0 }
end

# p factors(20)

def bubble_sort(array)
  bubble_sort!(array.dup)
end

def bubble_sort!(array)
  sorted = false

  until sorted
    sorted = true
    (0...array.size - 1).each do |i|
      if array[i] > array[i+1]
        sorted = false
        array[i], array[i+1] = array[i+1], array[i]
      end
    end
  end

  array
end

# arr = %w{b c a f d}
# p bubble_sort(arr)
# p arr

def substrings(string)
  substrings = []

  length = string.length
  (0...length).each do |start_i|
    (start_i...length).each do |end_i|
      substrings << string[start_i..end_i]
    end
  end

  substrings
end

# p substrings('cat')

def english_substrings(string)
  substrings = substrings(string)
  path = '/home/david/Dropbox/ruby/app-academy/week1/w1d2/dictionary.txt'
  words = File.read(path).split("\n")
  substrings.select { |substr| words.include?(substr) }
end

# p english_substrings('cat')