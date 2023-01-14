# k-1番目までAを選んだ時、Aをソートして
# a1 a2 a3
# a2 a2 a3
# a3 a3 a3
# こんな感じになる、すなわち
# a1 + 3 a2 + 5 a3 ...
# k番目が挿入されるとき、ak未満をn個、ak以上をm個とすると
# st[ak..] <- +2
# st[ak] <- (n * 2 + 1) * ak

require "crystal/modint9"
require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
# n = 200000
# a = Array.new(n) { rand(200000) }

cnt = a.max.succ.to_st_sum
sum = ST(ModInt).sum(a.max.succ)
ans = a[0].to_m
cnt[a[0]] = 1_i64
sum[a[0]] += a[0]

puts ans

(1...n).each do |i|
  ans += a[i].to_m * (cnt[...a[i]] * 2 + 1)
  cnt[a[i]] += 1
  ans += sum[a[i]..] * 2
  sum[a[i]] += a[i]
  puts ans // (i + 1) // (i + 1)
end
