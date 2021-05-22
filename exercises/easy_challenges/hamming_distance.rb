class DNA

  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(comp_strand)
    min_size = [comp_strand.size, @strand.size].min
    counter = 0
    min_size.times {|idx| counter += 1 if comp_strand[idx] != @strand[idx]}
    counter
  end

end
