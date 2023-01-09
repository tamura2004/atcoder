require "big"

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

n, m = gets.to_s.split.map(&.to_i64)

# ans = n * Σk=1..n, p(n-1,k-1)*(Σ0..k-1)*(n ** n-k)
# p(n-1,k-1)*(n**(n-k))*k*(k-1)//2

# p(n-1,0) = 1
# p(n-1,1) = n-1
# p(n-1,2) = (n-1)(n-2)
# p(n-1,i) = (n-1)! // (n-1-i)!
# p(n-1,n-1) = (n-1)!

p = [1_i64]
(1...n).each do |i|
  p << (p.last * (n - i)) % m
end

ans = 0.to_big_i
(1_i64..n).each do |k|
  cnt = k * (k - 1) // 2
  cnt %= m
  cnt *= modpow(n, n - k, m)
  cnt %= m
  cnt *= p[k - 1]
  cnt %= m
  ans += cnt
  ans %= m
end
ans *= n
ans %= m
pp ans
