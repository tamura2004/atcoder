require "crystal/segment_tree"
require "crystal/modint9"

alias X = Tuple(ModInt, ModInt)

n, q = gets.to_s.split.map(&.to_i64)

values = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64)
  X.new a.to_m, b.to_m
end

unit = X.new 1.to_m, 0.to_m

st = SegmentTree.new(values, unit) do |x, y|
  X.new y[0] * x[0], y[0] * x[1] + y[1]
end

q.times do
  cmd, a, b, c = gets.to_s.split.map(&.to_i64)
  case cmd
  when 0
    p, c, d = a, b, c
    st[p] = X.new c.to_m, d.to_m
  when 1
    l, r, x = a, b, c
    a, b = st[l...r]
    pp a * x + b
  end
end
