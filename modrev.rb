X,Y = gets.split.map &:to_i
MOD = 10 ** 9 + 7

def modinv(a,m)
  b,u,v = m,1,0
  while b > 0
    t = a / b
    a -= t * b; a,b = b,a
    u -= t * v; u,v = v,u
  end
  u %= m
end

def modfact(n,m)
  ans = 1
  (1..n).each do |i|
    ans *= i
    ans %= m
  end
  ans
end

v = modfact(333333,MOD)
r = modinv(v,MOD)
u = v * r % MOD
p [v, r, u]
