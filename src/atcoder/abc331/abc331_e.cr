require "crystal/graph"
require "crystal/st"

n, m, l = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

values = Array.new(m) do |i|
  { b[i], i.to_i64 }
end

st = values.to_st_max

g = Array.new(n) { [] of Int64 }
l.times do
  c, d = gets.to_s.split.map(&.to_i64.pred)
  g[c] << d
end

ans = 0_i64
n.times do |i|
  main = a[i]
  g[i].each do |j|
    st[j] = { Int64::MIN, j }
  end

  sub, _ = st[0..]
  chmax ans, main + sub

  g[i].each do |j|
    st[j] = { b[j], j }
  end
end

pp ans
