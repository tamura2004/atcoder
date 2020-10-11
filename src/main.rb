MOD = 10 ** 9 + 7

def solve(n, a, b)
  c = n - a - b
  return 0 if c < 0
  ans = tateyoko(n, a, b, c)
  ans %= MOD
  ans -= naname(n, a, b, c)
  ans %= MOD
  return ans
end

def tateyoko(n, a, b, c)
  ans = c + 1
  ans %= MOD
  ans *= (n - a + 1) * (c + 1) * (c + 2) / 2
  ans %= MOD
  ans *= (n - b + 1) * (c + 1) * (c + 2) / 2
  ans %= MOD
  return ans * 4
end

def naname(n, a, b, c)
  ans = (c + 1) * (c + 1)
  ans %= MOD
  ans *= ((c + 1) + c * (c + 1) / 2) ** 2
  ans %= MOD
  ans *= ((c + 1) ** 2 - c * (c + 1) / 2) ** 2
  ans %= MOD
  return ans * 4
end

t = gets.to_s.to_i
t.times do
  n, a, b = gets.to_s.split.map { |v| v.to_i }
  pp solve(n, a, b)
end
