class State
  getter y : Int32
  getter x : Int32

  def initialize(@x, @y)
  end

  def_equals_and_hash @y, @x
end

seen = Hash(State, Bool).new { |h, k| h[k] = false }
a = State.new(10,20)
b = State.new(10,20)
pp! seen[a]
pp! seen[b]
seen[a] = true
pp! seen[a]
pp! seen[b]
