# n * m - sum i, (a * i mod m)
# サイクルの長さ = m // m.gcd(a)

t = gets.to_s.to_i64
t.times do
  n, a, m = gets.to_s.split.map(&.to_i64)
  len = m // m.gcd(a)
  q, r = n.divmod(len)

  tot = (1..len).sum { |i| ((a*i).pred % m).succ }
  ans = tot * q
  (1..r).each do |i|
    ans += ((a*i).pred % m).succ
  end
  pp n * m - ans
end
