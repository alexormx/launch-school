class RomanNumeral
  def initialize(arabic)
    @arabic = arabic
    @roman = ""
    convert_to_roman(arabic)
  end

  def to_roman
    @roman
  end

  private
  def convert_to_roman(arabic)
    units, tens, hundreds, thousands = @arabic.digits
    unit_conv(thousands, "__", "_", "M") 
    unit_conv(hundreds, "M", "D", "C") 
    unit_conv(tens, "C", "L", "X") 
    unit_conv(units, "X", "V", "I")
  end

  def unit_conv(digit, upper, fifth, unit)
    return unless digit
    case digit
    when 9 then @roman += unit + upper
    when 6..8 then @roman += fifth + (unit * (digit % 5))
    when 5 then @roman += fifth
    when 4 then @roman += unit + fifth
    when 1..3 then @roman += unit * digit
    end
  end
end
