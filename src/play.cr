def inv_gcd(a, b) : Int128
  a = a.to_i128
  b = b.to_i128
  
  a = a % b

  if a < 0
    a += b
  end

  s, t = b, a
  m0, m1 = 0_i128, 1_i128

  while t != 0
    u = s // t
    s -= t * u
    m0 -= m1 * u
    tmp = s
    s = t
    t = tmp
    tmp = m0
    m0 = m1
    m1 = tmp
  end

  if m0 < 0
    m0 += b // s
  end

  return m0
end


x = 51189761537_i128
y = x // 2
# pp! x % y
# pp! x + y
pp! x * y
# pp! x // y

# pp inv_gcd(x,y)