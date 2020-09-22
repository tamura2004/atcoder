def ext_gcd(a, b)
  debug! [a,b]
  return b, 0, 1 if a.zero?
  g, y, x = ext_gcd(b % a, a)
  return g, x - (b//a)*y, y
end