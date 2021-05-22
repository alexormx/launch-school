class Diamond
  class << self
    def make_diamond(letter)
      letter_code = letter.ord
      generate_code(letter_code)
    end

    def generate_code(code)
      result = []
      insertions = code - 65
      puts insertions
      0.upto(insertions) do |idx|
        str = idx == 0 ? "A" : (65 + idx).chr 
        result << str
      end
      result
    end
  end
end

a = Diamond.make_diamond("A")
puts a



