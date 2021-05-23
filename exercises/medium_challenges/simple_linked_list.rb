class Element
  attr_reader :datum, :next

  def initialize(datum, next_element = nil)
    @datum = datum
    @next = next_element
  end

  def tail?
    @next.nil?
  end

end

class SimpleLinkedList
  attr_reader :head

  def size
    size = 0
    current_element = @head
    while current_element
      size += 1
      current_element = current_element.next
    end
    size
  end

  def empty?
    @head.nil?
  end

  def push(datum)
    element = Element.new(datum, @head)
    @head = element
  end

  def peek
    @head.datum if @head
  end

  def pop
    datum = peek
    new_head = @head.next
    @head = new_head
    datum
  end

  def self.from_a(array)
    array = [] if array.nil?

    list = SimpleLinkedList.new
    array.reverse_each { |datum| list.push(datum)}
    list
  end

  def to_a
    array = []
    current_element = head
    while !current_element.nil?
      array.push(current_element.datum)
      current_element = current_element.next
    end
    array
  end

  def reverse
    list = SimpleLinkedList.new
    current_element = head
    while !current_element.nil?
      list.push(current_element.datum)
      current_element = current_element.next
    end
    list
  end
end

