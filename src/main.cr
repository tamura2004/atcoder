require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

def solve(a)
  st = SegmentTree(Int64).range_max_query(a.max+1)
  a.each do |i|
    st[i] = st[i+1..] + 1
  end
  st[0..]
end

cnt = solve(a)
a.rotate!
ans = Math.min cnt, solve(a)
pp ans

