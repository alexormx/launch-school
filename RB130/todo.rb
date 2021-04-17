# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title
  attr_reader :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError.new("Can only add Todo objects") unless todo.instance_of? Todo
    
    @todos << todo
  end
  alias_method :add, :<<

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end
  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    self.todos.all? {|item| item.done?}
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end
  
  def to_s
    text = "---- #{self.title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos.clone
  end

  def each
    counter = 0
    while counter < @todos.size
      item = @todos[counter]
      yield(item)
      counter += 1
    end
    self
  end

  def select
    result = TodoList.new(self.title)
    counter = 0
    while counter < @todos.size
      item = @todos[counter]
      result << item if yield(item)
      counter += 1
    end
    result
  end

  def find_by_title(title)
    self.each do |item|
      if item.title == title
        return item
      end
    end
    nil
  end

  def all_done
    self.select do |item|
      item.done?
    end
  end

  def all_not_done
    self.select do |item|
      !item.done?
    end
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    self.each do |item|
      item.done!
    end
  end

  def mark_all_undone
    self.each do |item|
      item.undone!
    end
  end
end

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list


list.first.done!

puts list 

list.mark_all_done

puts list

list.mark_all_undone

puts list