class Diamond
  class << self
    def make_diamond(letter)
      letter_code = letter.ord
      generate_code(letter_code)
    end

    private
    def generate_code(code)
      result = []
      result << " " * (code - 65) + "A" + " " * (code - 65)
      66.upto(code) { |idx| result << get_line(code, idx) }
      (code - 1).downto(66) {|idx| result << get_line(code, idx) }
      result << " " * (code - 65) + "A" + " " * (code - 65) if code > 65
      result.join("\n") + "\n"
    end

    def get_line(code, idx)
      initial = " " * (code - idx)
      mid = " " * (((idx - 65) * 2) - 1)
      initial + idx.chr + mid + idx.chr + initial
    end
  end
end
