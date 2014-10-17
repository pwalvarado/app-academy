def my_transpose(matrix)
  new_matrix = Array.new(matrix.size) { Array.new }
  matrix.each_with_index do |array, i|
    array.each_index do |j|
      new_matrix[j][i] = matrix[i][j]
    end
  end
  new_matrix
end