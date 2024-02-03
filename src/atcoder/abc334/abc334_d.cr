require "crystal/indexable"

n, q = gets.to_s.split.map(&.to_i64)
r = gets.to_s.split.map(&.to_i64).sort.cs
q.times do
  x = gets.to_s.to_i64
  ans = r.count_less_or_equal(x).pred
  pp ans
end
