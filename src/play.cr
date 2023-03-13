require "big"

def modpow(a, b, mod)
  ans = 1.to_big_i
  while b > 0
    if b.odd?
      ans *= a
      ans %= mod
    end
    b //= 2
    a *= a
    a %= mod
  end
  ans
end

a,x,m = gets.to_s.split.map(&.to_i64.to_big_i)
if a == 1
  pp x % m
else
  pp modpow(a, x, m * (a - 1)).pred // a.pred % m
end

