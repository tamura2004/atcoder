require "crystal/cc"
require "crystal/coodinate_compress_segment_tree_2d"

n = gets.to_s.to_i
keys = [] of Tuple(Int64,Int64)
events = Array.new(n) do
  t, x, y, w = gets.to_s.split.map(&.to_i64)
  a = t - x - y
  b = t + x - y
  keys << {a,b}
  {y, a, b, w}
end.sort
keys << {0_i64,0_i64}

st = CCST2D(Int64,Int64).new(keys: keys, unit: Int64::MIN) do |i, j|
  Math.max(i, j)
end
st[0_i64,0_i64] = 0_i64

events.each do |y, a, b, w|
  st[a, b] = st[..a, ..b] + w
end

pp st[0.., 0..]
