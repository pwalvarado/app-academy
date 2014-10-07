class Fixnum
  def in_words
    units_words = Hash[nil, '', 0, 'zero', 1, 'one', 2, 'two', 3, 'three', 4, 'four',
                   5, 'five', 6, 'six', 7, 'seven', 8, 'eight', 9, 'nine',
                   10, 'ten', 11, 'eleven', 12, 'twelve', 13, 'thirteen',
                   14, 'fourteen', 15, 'fifteen', 16, 'sixteen',
                   17, 'seventeen', 18, 'eighteen', 19, 'nineteen']
    tens_words = Hash[2, 'twenty', 3, 'thirty', 4, 'forty', 5, 'fifty',
      6, 'sixty', 7, 'seventy', 8, 'eighty', 9, 'ninety']
    raise "NO negative numbers allowed." if self < 0
    if self < 20
      return units_words[self]
    elsif self < 100
      tens = self / 10
      remainder = ( self % 10 == 0 ? nil : self % 10 )
      return [tens_words[tens], units_words[remainder]].join(' ').strip
    elsif self < 1000
      hundreds = self / 100
      
      return 
    end
  end
end
