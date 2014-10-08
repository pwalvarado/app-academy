def find_number
  i = 251
  loop do
    return i if i % 7 == 0
    i += 1
  end
end

# p find_number

def factors(number)
  1.upto(number).select { |factor| number % factor == 0 }
end

# p factors(945)

def bubble_sort(array)
  sorted = false
  until sorted
    sorted = true
    
    0.upto(array.size - 2).each do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
    end
  end
  
  array
end

# p bubble_sort([2,1,5,3,8])

def substrings(string)
  substrings = []
  
  (0...string.length).each do |start_index|
    (start_index...string.length).each do |end_index|
      substrings << string[start_index..end_index]
    end
  end
  
  substrings
end

# p substrings('cat')

def subwords(string)
  dictionary = File.read('dictionary.txt').split(/\n/)
  substrings(string).select { |substring| dictionary.include? (substring) }
end

# p subwords('cat')























