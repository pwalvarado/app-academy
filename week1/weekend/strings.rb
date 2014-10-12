def num_to_s(num, base)
  result_length = 1
  result_length += 1 until ( base ** result_length - 1 ) >= num
  string = ""
  remaining = num
  (result_length-1).downto(0) do |digits_place|
    digit = remaining / (base ** digits_place)
    remaining -= digit * (base ** digits_place)
    string << digit.to_string
  end
  string
end

class Fixnum
  def to_string
    case self
    when (0..9) then String(self)
    when (10..15)
      chars_idx = self - 10
      %w{A B C D E F}[chars_idx]
    end
  end
end

# p num_to_s(5, 10) #=> "5"
# p num_to_s(5, 2)  #=> "101"
# p num_to_s(5, 16) #=> "5"

# p num_to_s(234, 10) #=> "234"
# p num_to_s(234, 2)  #=> "11101010"
# p num_to_s(234, 16) #=> "EA"

def caesar(str, shift)
  alphabet = ('a'..'z').to_a.join
  cipherbet = ('a'..'z').to_a.rotate(shift).join
  str.tr(alphabet, cipherbet)
end

# p caesar("hello", 3)