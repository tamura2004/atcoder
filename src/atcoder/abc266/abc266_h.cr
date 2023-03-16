require "crystal/cc"
require "crystal/segment_tree_2d"

n = gets.to_s.to_i
# n = 100000
ai = [0_i64]
bi = [0_i64]
events = Array.new(n) do
  t, x, y, w = gets.to_s.split.map(&.to_i64)
  # t = rand(1000000000_i64)
  # x = rand(1000000000_i64)
  # y = rand(1000000000_i64)
  # w = rand(1000000000_i64)
  a = t - x - y
  b = t + x - y
  ai << a
  bi << b
  {y, a, b, w}
end.sort

ai << 0_i64
bi << 0_i64
cca = ai.to_cc
ccb = bi.to_cc
h = cca.size
w = ccb.size

st = SegmentTree2D(Int64).new(h, w, 0_i64) do |i, j|
  Math.max(i, j)
end
st[cca[0], ccb[0]] = 0_i64

events.each do |y, a, b, w|
  st[cca[a], ccb[b]] = st[..cca[a], ..ccb[b]] + w
end

pp st[0.., 0..]
