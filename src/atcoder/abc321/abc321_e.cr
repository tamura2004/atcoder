# 頂点iから距離kにありn以下の子孫
def solve(i, k, n)
  return 0_i64 if Math.ilogb(n) - Math.ilogb(i) < k
  lo = i * 2_i64 ** k
  hi = (i + 1) * 2_i64 ** k
  (lo...Math.min(n+1, hi)).size.to_i64
end

t = gets.to_s.to_i64
t.times do
  n, x, k = gets.to_s.split.map(&.to_i64)
  ans = solve(x, k, n)

  while x > 1 && k > 0
    if k == 1
      ans += 1
      x >>= 1
      k -= 1
    else
      ans += solve(x ^ 1, k - 2, n)
      x >>= 1
      k -= 1
    end
  end

  pp ans
end
