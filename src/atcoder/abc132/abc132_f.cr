require "crystal/indexable"
require "crystal/mod_int"

def isqrt(value : Int::Primitive)
  return value if value < 2
  res = value.class.zero
  bit = res.succ << (res.leading_zeros_count - 2)
  bit >>= value.leading_zeros_count & ~0x3
  while (bit != 0)
    if value >= res + bit
      value -= res + bit
      res = (res >> 1) + bit
    else
      res >>= 1
    end
    bit >>= 2
  end
  res
end

n, m = gets.to_s.split.map(&.to_i64)
r = isqrt(n)
cnt = [] of Int64
(1..r).each do |i|
  cnt << n // i - n // (i + 1)
end

(1..r).reverse_each do |i|
  next if i == r && n // r == r
  cnt << 1_i64
end

cnt.reverse!

k = cnt.size
dp = make_array(0.to_m, m+1, k)
k.times do |i|
  dp[0][i] = cnt[i].to_m
end

m.times do |i|
  cs = dp[i].cs(head: false).reverse
  k.times do |j|
    dp[i+1][j] = dp[0][j] * cs[j]
  end
end

pp dp[-1][0]
