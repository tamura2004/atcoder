require "crystal/segment_tree"

alias T = Tuple(Char,Int32)
unit = T.new '{', -1

n,k = gets.to_s.split.map(&.to_i)
a = gets.to_s.chars.zip(0..)
st = SegmentTree.range_min_query(a, unit)

ans = [] of Char
lo = 0
hi = n - k + 1

k.times do
  v,i = st[lo...hi]
  ans << v
  hi += 1
  lo = i + 1
end

puts ans.join
