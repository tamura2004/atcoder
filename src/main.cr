require "crystal/modint9"
require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
st = SegmentTree(ModInt).range_sum_query(n)

b = a.zip(0..).sort.reverse
# pp! b
ans = 0.to_m
b.each do |v, i|
  ans += st[i..] // (2.to_m ** (i + 1))
  # pp! ans
  st[i] += 2.to_m ** i
end

pp ans