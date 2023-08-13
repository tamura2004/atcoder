require "crystal/multiset"

n, k, q = gets.to_s.split.map(&.to_i64)
a = Array.new(n, 0_i64)
cnt = a.to_multiset_sum

q.times do
  x, y = gets.to_s.split.map(&.to_i64)
  x -= 1
  cnt.delete(a[x])
  cnt << y
  a[x] = y

  pp cnt.acc_upper_count(k)
end
