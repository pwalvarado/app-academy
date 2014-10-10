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