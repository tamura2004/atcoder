def solve(m, l, r)
  (r - l) // m + 1
end

a, m, l, r = gets.to_s.split.map(&.to_i64)
l -= a
r -= a

r -= r % m
l += m - 1
l -= l % m

pp solve(m, l, r)