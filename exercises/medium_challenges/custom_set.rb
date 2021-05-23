class CustomSet
  def initialize(set = [])
    @elements = set.uniq
  end

  def empty?
    elements.empty?
  end

  def intersection(other_set)
    same_elements = elements.select { |el| other_set.contains?(el) }
    CustomSet.new(same_elements)
  end

  def union(other_set)
    union_set = CustomSet.new(elements)
    other_set.elements.each { |el| union_set.add(el) }
    union_set
  end

  def difference(other_set)
    different_elements = elements.select { |el| !other_set.contains?(el) }
    CustomSet.new(different_elements)
  end

  def disjoint?(other_set)
    elements.none? { |el| other_set.contains?(el) }
  end

  def eql?(other_set)
    return false unless elements.length == other_set.elements.length
    elements.all? { |el| other_set.contains?(el) }
  end

  def subset?(other_set)
    elements.all? { |el| other_set.contains?(el) }
  end

  def add(element)
    elements.push(element) unless contains?(element)
    self
  end

  def contains?(element)
    elements.include?(element)
  end

  def ==(other_set)
    eql?(other_set)
  end

  protected

  attr_accessor :elements
end