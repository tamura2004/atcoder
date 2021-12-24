# 1 + 1 + 2 + 4 + 8 + ...
# 1 2 4 8
# 2^n-1

# i bitが最上位bitである数のうち
# n以下であるものの数
def calc(l, r, i)
  lo = (1_i64 << i)
  hi = (1_i64 << (i + 1))

  chmax lo, l
  chmin hi, r + 1

  (lo...hi).size
end

n, l, r = gets.to_s.split.map(&.to_i64)
ans = 0_i64

100.times do |i|
  next if n.bit(i) == 0
  ans += calc(l, r, i)
end

pp ans
