require "crystal/segment_tree"

n,m = gets.to_s.split.map(&.to_i)
st = n.to_st_min
st[0] = 0_i64

pathes = (0...m).map do
  lo, hi, cost = gets.to_s.split.map(&.to_i64)
  lo = lo.to_i.pred
  hi = hi.to_i.pred
  {lo,hi,cost}
end.sort

pathes.each do |lo,hi,cost|
  pre = st[lo...hi]
  next if pre == Int64::MAX
  chmin st[hi], pre + cost
end

ans = st[n-1]
pp ans == Int64::MAX ? -1 : ans
