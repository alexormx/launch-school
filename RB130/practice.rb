# method implementation
def test
  yield(1, 2)                           # passing 2 block arguments at block invocation time
end

# method invocation
test { |num| puts num } 