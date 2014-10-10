class WordChainer
  require 'set'
  attr_accessor :current_words, :all_seen_words
  attr_reader :dictionary
  
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end
  
  def adjacent_words(word)
    dictionary.select { |other_word| adjacent?(word, other_word) }
  end
  
  def adjacent?(word1, word2)
    return false unless word1.length == word2.length
    differences = 0
    word1.length.times do |i|
      differences += 1 unless word1[i] == word2[i]
      return false if differences >= 2
    end
    
    true
  end
  
  def run(source, target)
    self.current_words = Set.new([source])
    self.all_seen_words = Hash[source, nil]
    
    until current_words.empty?
      self.current_words = explore_current_words
      break if all_seen_words.keys.include?(target)
    end
    
    p build_path(source, target)
  end
  
  def explore_current_words
    new_current_words = Set.new
    current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        if !all_seen_words.include?(adj_word)
          new_current_words << adj_word
          all_seen_words[adj_word] = current_word
        end
      end
    end
    new_current_words
    # new_current_words.each do |new_current_word|
    #   puts "#{new_current_word} from #{all_seen_words[new_current_word]}"
    # end
  end
  
  def build_path(source, target)
    path = []
    current_word = target
    until all_seen_words[current_word].nil?
      path << current_word
      current_word = all_seen_words[current_word]
    end
    path.reverse!
    path.unshift(source)
  end
end

word_chainer = WordChainer.new('dictionary.txt')
word_chainer.run("duck", "mock")


















