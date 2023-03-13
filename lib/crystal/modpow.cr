require "crystal/prime"

# a ** b (mod)
def modpow(a, b, mod)
  a = a.to_i64
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
  ans
end

def euler(n)
  pf = n.prime_factors
  ans = n
  pf.each do |p|
    ans *= p - 1
  end
  pf.each do |p|
    ans //= p
  end
  ans
end
