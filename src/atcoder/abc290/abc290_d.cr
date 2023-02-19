t = gets.to_s.to_i
t.times do
  n,d,k = gets.to_s.split.map(&.to_i64)
  g = n.gcd(d)
  if g == 1
    ans = (d * (k - 1)) % n
    pp ans
  else
    q,r = (k-1).divmod(n//g)
    # pp! [g,q,r]
    ans = (q + d * r) % n
    pp ans
  end
end
