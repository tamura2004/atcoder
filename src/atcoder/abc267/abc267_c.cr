# 更新をセグ木で
require "crystal/segment_tree"

n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
st = a.to_st_sum

sum = (1..m).sum do |i|
  a[i-1] * i
end

ans = sum
(n-m).times do |i|
  sum = sum + a[i+m] * m - st[i...(i+m)]
  chmax ans, sum
end

pp ans