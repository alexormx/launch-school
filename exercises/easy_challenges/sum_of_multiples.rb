class SumOfMultiples
  attr_reader :multiples
  def initialize(*multiples)
    @multiples = multiples.size > 0 ? multiples : [3, 5]
  end

  def self.to(num)
    SumOfMultiples.new().to(num)
  end

  def to(num)
    (1...num).select do |current_num|
      any_multiple?(current_num)
    end.sum
  end

  def any_multiple?(num)
    multiples.any? do |multiple|
      num % multiple == 0
    end
  end
end
