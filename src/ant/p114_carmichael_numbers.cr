def modpow(a, b, mod)
  ans = 1_i64
  while b > 0
    if b.odd?
      ans *= a
      ans %= mod
    end
    b //= 2
    a *= a
    a %= mod
  end
  return ans
end

n = 561
ans = 2.upto(n - 1).all? do |x|
  modpow(x, n, n) == x
end
pp ans
