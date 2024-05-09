require "crystal/cc"
require "crystal/st"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
cc = a.to_cc
sum = n.to_st_sum
cnt = n.to_st_sum

ans = 0_i64
(0...n).reverse_each do |i|
  j = cc[a[i]]
  ans += sum[j..] - cnt[j..] * a[i]
  sum[j] += a[i]
  cnt[j] += 1_i64
end

pp ans