  def self.combinations(total, denoms)
    return [total] if denoms.include?(total)
    all_combinations = []
    denoms.each do |denom|
      next if denom > total
      remaining = total - denom
      all_combinations += add_to_each(denom, [combinations(remaining, denoms)])
    end
    all_combinations
  end

  def self.add_to_each(num, arrays)
    arrays.map { |array| [num] + array }
  end
end
