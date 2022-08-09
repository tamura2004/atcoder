require "crystal/complex"
require "crystal/segment_tree"

n = gets.to_s.to_i64
a = Array.new(n) do
  c, p = gets.to_s.split.map(&.to_i64)
  c == 1 ? p.x : p.y
end
st = a.to_st_sum

q = gets.to_s.to_i64
q.times do
  lo, hi = gets.to_s.split.map(&.to_i64)
  ans = st[lo-1...hi]
  puts "#{ans.x} #{ans.y}"
end
