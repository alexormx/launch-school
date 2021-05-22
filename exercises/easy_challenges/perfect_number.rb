class PerfectNumber
 
  def self.classify(num)
    raise StandardError.new if num < 1
    sum = sum_of_factors(num)
  
    if sum == num
      "perfect"
    elsif sum > num
      "abundant"
    else
      "deficient"
    end
  end

  class << self
    private
    
    def sum_of_factors(num)
      (1...num).select do |possible_divisor|
        num % possible_divisor == 0
      end.sum
    end
  end
end