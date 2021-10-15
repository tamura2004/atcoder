require "crystal/mod_int"

t = gets.to_s.to_i
t.times do
  n,a,b = gets.to_s.split.map(&.to_i64)
  a,b = b,a unless a <= b
  pp solve(a,b,n)
end

def solve(a,b,n)
  return 0 if n < a + b

  n = n.to_m
  a = a.to_m
  b = b.to_m

  all = (n - a + 1) ** 2 * (n - b + 1) ** 2
  inner = (n - b + 1) * (b - a + 1)
  outer = (a - 2) * (a - 2 + 1) // 2 + (a - 1) * (n - a - b + 2)
  all - (inner + outer * 2) ** 2
end
