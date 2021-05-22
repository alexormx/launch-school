class Octal
  attr_reader :octal
  def initialize(octal)
    @octal = octal
  end

  def to_decimal
    return 0 unless valid_octal?(octal)
    digits = @octal.to_i.digits
    total = 0
    digits.each_with_index do |num, idx|
      total += num * (8**idx)
    end
    total
  end
 
  def valid_octal?(num)
    num.chars.all? {|n| n =~ /[0-7]/}
  end
 
end