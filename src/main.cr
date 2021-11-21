<<<<<<< HEAD
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

=======
require "crystal/complex"
require "crystal/indexable"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

xs = a.map{|v| C.new v, -1 } + b.map{|v| C.new v, 1 }
xs.sort!

costs = xs.map(&.imag).cs
dists = [0_i64] + xs.map(&.real)

ans = Int64::MAX
>>>>>>> 09034679e4caba443fdb91423e6ad92e8b817ee9
