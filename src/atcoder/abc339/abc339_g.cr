require "crystal/merge_sort_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
mst = MergeSortTree(Int64).new(a)

q = gets.to_s.to_i
ans = 0_i64
q.times do
  q1, q2, q3 = gets.to_s.split.map(&.to_i64)
  lo = q1 ^ ans
  hi = q2 ^ ans
  x = q3 ^ ans
  lo -= 1

  ans = mst.range_sum_under(lo, hi, x)
  pp ans
end
