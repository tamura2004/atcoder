require "crystal/lst"
require "crystal/lazy_segment_tree"
require "crystal/modint9"

PW10 = [1.to_m]
200_001.times do
  PW10 << PW10[-1] * 10
end

NM11 = [0.to_m]
200_001.times do
  NM11 << NM11[-1] * 10 + 1
end

struct X
  getter val : ModInt
  getter len : Int32

  def initialize(@val : ModInt, @len : Int32)
  end

  def +(b : self)
    X.new(val * PW10[b.len] + b.val, len + b.len)
  end

  def *(a : Int32)
    X.new(NM11[len] * a, len)
  end

  def to_s(io)
    io << val
  end
end

n, q = gets.to_s.split.map(&.to_i64)
values = Array.new(n) { X.new(1.to_m, 1) }

st1 = LST(X, Int32).new(
  values,
  ->(x : X, y : X) { x + y },
  ->(x : X, a : Int32) { x * a },
  ->(a : Int32, b : Int32) { b }
)

st2 = LazySegmentTree(X?, Int32?).new(
  values: values,
  fxx: ->(x : X?, y : X?) { x && y ? x + y : x ? x : y ? y : nil },
  fxa: ->(x : X?, a : Int32?) { x && a ? x * a : x ? x : nil },
  faa: ->(a : Int32?, b : Int32?) { b ? b : a },
  x_unit: nil,
  a_unit: nil
)

q.times do
  lo, hi, d = gets.to_s.split.map(&.to_i64)
  lo -= 1

  st1.apply(lo, hi, d.to_i)
  got = st1.query(0, n).not_nil!.val

  st2[lo...hi] = d.to_i
  want = st2[0...n].not_nil!.val

  pp! got
  pp! want

  if got != want
    pp "error"
    puts st1
  end
end
