k = gets.to_s.to_i

def s(n)
  n / n.to_s.chars.sum(&.to_i64)
end

def pow10(n)
  10_i64 ** n
end

INF = 1e16.to_i64

def f(n)
  ans = {INF, INF}
  (0..15).reverse_each do |d|
    x = pow10(d + 1) * (n // pow10(d + 1) + 1) - 1
    chmin ans, {s(x), x}
  end
  chmin ans, {s(n), n}
  ans[1]
end

n = 1_i64
k.times do
  pp n
  n = f(n + 1)
end
