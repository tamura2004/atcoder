require "crystal/lst"
require "crystal/modint9"

PW10 = [1.to_m]
200_001.times do
  PW10 << PW10[-1] * 10
end

NM11 = [0.to_m]
200_001.times do
  NM11 << NM11[-1] * 10 + 1
end

record X, val : ModInt, len : Int32 do
  delegate to_s, to: val

  def +(b : self)
    X.new(val * PW10[b.len] + b.val, len + b.len)
  end

  def *(a : Int32)
    X.new(NM11[len] * a, len)
  end
end

n, q = gets.to_s.split.map(&.to_i64)
values = Array.new(n) { X.new(1.to_m, 1) }

st = LST(X, Int32).new(
  values,
  ->(x : X, y : X) { x + y },
  ->(x : X, a : Int32) { x * a },
  ->(a : Int32, b : Int32) { b }
)

4.times do |h|
  (8 >> h).times do |i|
    st[(i << h)...(i.succ << h)] = h + 2
  end
end

puts st