# 文字種ごとの個数がすべて偶数　<=> うれしい
# 左右から累積和
require "crystal/indexable"

D = 10

s = gets.to_s.chars.map(&.to_i)
n = s.size
ans = 0_i64
tot = 0_i64
cnt = Array.new(1<<D, 0_i64)
cnt[0] = 1_i64

n.times do |i|
  tot ^= (1 << s[i])
  # pp! tot.to_s(2)
  ans += cnt[tot]
  cnt[tot] += 1
end

pp ans

