def inv(a, b)
  p = b.to_i128
  x, y, u, v = 1_i128, 0_i128, 0_i128, 1_i128
  while b > 0
    k, r = a.divmod(b)
    x -= k * u
    y -= k * v
    x, u, y, v, a, b = u, x, v, y, b, r
  end
  x % p
end

def garner(m, a)
  ans = 0_i128
  mod = 1_i128

  m.zip(a).each do |m, a|
    ans += mod * inv(mod, m) * (a - ans)
    mod *= m
  end
  ans % mod
end

m1 = 1_224_736_769_i128
m2 = 469_762_049_i128
m3 = 167_772_161_i128

pp! inv(1, m1)
pp! inv(m1, m2)
pp! inv(m1 * m2, m3)

# ans = 0_i128
# mod = 1_i128

# ans += mod * inv(mod, m1) * (10_i128 - ans)
# mod *= m1

# ans += mod * inv(mod, m2) * (20_i128 - ans)
# mod *= m2

# pp! mod
# pp! mod * inv(mod, m3)
# pp! mod * inv(mod, m3) * (30_i128 - ans)

# ans += mod * inv(mod, m3) * (30_i128 - ans)
# mod *= m3


# x + m1 * t = r1

# x = r2 (mod m3)
# x = r3 (mod m3)