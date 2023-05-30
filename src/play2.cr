require "crystal/modint9"
require "crystal/lst"

PW10 = [] of ModInt
x = 1.to_m
200_001.times do
  PW10 << x
  x *= 10
end

PW11 = [] of ModInt
x = 0.to_m
200_001.times do
  PW11 << x
  x *= 10
  x += 1
end

class Node
  getter val : ModInt
  getter len : Int32
  delegate to_s, inspect, to: val

  def initialize(@val, @len)
  end

  def self.zero
    new(1.to_m, 1)
  end

  def +(y : self)
    Node.new(val * PW10[y.len] + y.val, len + y.len)
  end

  def *(a : Int32)
    Node.new(PW11[len] * a, len)
  end
end

n, q = gets.to_s.split.map(&.to_i)
st = LST(Node, Int32).new(
  values: Array.new(n) { Node.zero },
  fxx: ->(x : Node, y : Node) { x + y },
  fxa: ->(x : Node, a : Int32) { x * a },
  faa: ->(a : Int32, b : Int32) { b }
)

q.times do
  l, r, d = gets.to_s.split.map(&.to_i)
  l -= 1
  r -= 1
  st[l..r] = d
  pp st.sum
end
