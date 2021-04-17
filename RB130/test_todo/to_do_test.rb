require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative '../todo'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    item = @list.shift
    assert_equal(@todo1, item)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    item = @list.pop
    assert_equal(@todo3, item)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_add_raise_error
    assert_raises(TypeError) {@list.add(1)}
    assert_raises(TypeError) {@list.add("hello")}
  end

  def test_shovel
    todo4 = Todo.new("Pay card")
    @todos << todo4
    @list << todo4
    assert_equal(@todos, @list.to_a)
  end

  def test_shovel
    todo4 = Todo.new("Pay card")
    @todos << todo4
    @list.add(todo4)
    assert_equal(@todos, @list.to_a)
  end
  
  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
    assert_raises(IndexError) {@list.item_at(5)}
  end

  def test_done_at
    @list.mark_done_at(0)
    assert_equal(true, @list.first.done?)
    assert_raises(IndexError) {@list.mark_done_at(5)}
  end

  def test_undone_at
    @list.mark_all_done
    @list.mark_undone_at(0)
    assert_equal(false, @list.first.done?)
    assert_raises(IndexError) {@list.mark_undone_at(5)}
  end

  def test_done_bang
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
  
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
  
    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each_returns_original_list
    assert_equal(@list, @list.each {|todo| nil })
  end

  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)
  
    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
end