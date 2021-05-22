class Scrabble
  attr_reader :score
  def initialize(word)
    @word = word
    @score = 0
    generate_score if word
  end

  class << self
    def score(word)
      Scrabble.new(word).score
    end
  end

  private
  def generate_score
    letters = @word.downcase.chars
    letters.each do |char|
      case char
        when *%w(a e i o u l n r s t) then @score += 1
        when *%w(d g) then @score += 2
        when *%w(b c m p) then @score += 3
        when *%w(f h v w y) then @score += 4
        when "k" then @score += 5
        when *%w(j x) then @score += 8
        when *%w(q z) then @score += 10
      end
    end
  end
end 