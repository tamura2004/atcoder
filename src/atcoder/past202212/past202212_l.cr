# lの昇順、hの降順にソート
# hのLIS（最長減少部分列）が答え

require "crystal/indexable"
require "crystal/segment_tree"

n = gets.to_s.to_i64
a = Array.new(n) do
  lo, hi = gets.to_s.split.map(&.to_i64)
  {lo, hi}
end.sort_by { |lo, hi| {lo, -hi} }.map(&.last).compress

st = SegmentTree(Int64).new(
  values: Array.new(n, 0_i64),
  unit: Int64::MIN
) { |x, y| Math.max(x, y) }
a.each do |v|
  st[v] = st[v..] + 1
end

pp st[0..]
