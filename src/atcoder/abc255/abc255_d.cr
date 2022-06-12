require "crystal/cumulative_sum"

n,q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
tr = CS(Int64).new(a)

q.times do
  x = gets.to_s.to_i64

  c_hi = tr.count_upper(x)
  s_hi = tr.sum_upper(x)

  c_lo = tr.count_lower(x)
  s_lo = tr.sum_lower(x)

  ans = x * (c_lo - c_hi) + s_hi - s_lo
  pp ans
end