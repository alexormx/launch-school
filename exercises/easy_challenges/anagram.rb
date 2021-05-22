class Anagram
  attr_reader :word
  
  def initialize(word)
    @word = word
  end

  def match(arr)
    arr.select do |curr_word|
      curr_word.downcase != word.downcase && curr_word.size == word.size && is_anagram?(word, curr_word)
    end
  end
  
  private

  def sorted_word(curr_word)
    curr_word.downcase.chars.sort.join
  end  

  def is_anagram?(word1, word2)
    sorted_word(word1) == sorted_word(word2)
  end
end
