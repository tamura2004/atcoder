require "crystal/st"
require "crystal/indexable"

n, m, p = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort

st = b.to_st_sum

ans = a.sum do |v|
  cnt = b.count_less(p - v)
  cnt * v + (st[...cnt]? || 0_i64) + p * (m - cnt)
end

pp ans
