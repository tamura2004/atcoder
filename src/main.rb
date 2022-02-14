MOD = 998244353

INV = Array.new(200) do |i|
  i.zero? ? 0 : i.pow(MOD - 2, MOD)
end

def h(n, k)
  ans = 1
  # c(n+k-1,k-1)
  (k - 1).times do |i|
    ans *= n + k - 1 - i
    ans %= MOD
    ans *= INV[k - 1 - i]
    ans %= MOD
  end
  ans
end

n, k = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)

a[0] -= k
(1...n).each do |i|
  a[0] -= a[i]
end

if a[0] < 0
  pp 0
  exit
end

ans = 1
n.times do |i|
  ans *= h(a[i], k)
  ans %= MOD
end
pp ans
