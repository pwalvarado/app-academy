def num_to_s(num, base)
  hex = Hash[0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9,
    10, "A", 11, "B", 12, "C", 13, "D", 14, "E", 15, "F"]
  pow = 0
  result = ""
  until base ** pow > num
    result << hex[(num / (base ** pow) % base)].to_s
    pow += 1
  end
  result.reverse
end

# p num_to_s(5, 10) #=> "5"
# p num_to_s(5, 2)  #=> "101"
# p num_to_s(5, 16) #=> "5"
#
# p num_to_s(234, 10) #=> "234"
# p num_to_s(234, 2)  #=> "11101010"
# p num_to_s(234, 16) #=> "EA"

def caesar(str, shift)
  alphabet = ('a'..'z').to_a.join("")
  cipherbet = ('a'..'z').to_a.rotate(shift).join("")
  str.tr(alphabet, cipherbet)
end

p caesar("hello", 3)
p caesar("hello who am i?", 3)
p caesar("hello who am i?", -1)