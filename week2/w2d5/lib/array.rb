class Array
  def my_uniq
    uniq = []
    self.each do |el|
      uniq << el unless uniq.include?(el)
    end
    
    uniq
  end
  
  def two_sum
    two_sums = []
    (0...length-1).each do |i|
      (i+1...length).each do |j|
        two_sums << [i, j] if self[i] + self[j] == 0
      end
    end
    
    two_sums
  end
end