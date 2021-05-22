class Series
  def initialize(num)
    @num = num.chars.map(&:to_i)

  end

  def slices(parts)
    raise ArgumentError if @num.size < parts
    array_size = @num.size - parts + 1
    result = []
    array_size.times do |idx|
      result << @num[idx...idx+parts]
    end
    result
  end

end
