require "crystal/modint9"

n,k,m = gets.to_s.split.map(&.to_i64)
# if m % ModInt::MOD == 0
#   pp 0
#   exit
# end

x = modpow(k, n)
ans = m.to_m ** x
pp ans

# a ** b (mod - 1)
def modpow(a,b)
  mod = ModInt::MOD - 1
  ans = 1_i64
  while b > 0
    if b.odd?
      ans %= mod
      ans *= a 
      ans %= mod
    end
    b //= 2
    a %= mod
    a *= a
    a %= mod
  end
  ans
end

