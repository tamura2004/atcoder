require "big"

# 拡張ユークリッド互除法
# ax + by = gcd(a,b) = gを解く
#
# ```
# 3x + 7y = 1 # => x = -2, y = 1, g = 1
# ```
def ext_gcd(a, b)
  x, y, u, v = 1_i64, 0_i64, 0_i64, 1_i64
  while !b.zero?
    k = a // b
    x -= k * u
    y -= k * v
    x, u = u, x
    y, v = v, y
    a, b = b, a % b
  end
  return x, y, a
end

# 中国剰余定理
# 連立合同式を解き、解とmodをBigIntで返す
#
# ```
# x = 3 (mod 6)
# x = 1 (mod 4) # => x = 9 (mod 12)
# crt(3,6,1,4) #=> {9, 12}
#
# 解が無い場合nil
# crt(3,6,2,4) # => nil
# ```
def crt(b1, m1, b2, m2) : Tuple(BigInt,BigInt)?
  p, q, d = ext_gcd(m1, m2)
  return nil if (b2 - b1) % d != 0

  m = m1.to_big_i.lcm(m2)
  s = (b2 - b1) // d
  ans = (s.to_big_i * p * m1 + b1) % m
  return ans, m
end

# モジュラ逆数
# ax + by = 1 => ax = 1 (mod b) => x = a'
#
# ```
# 2x = 1 (mod 11) => x = 6
# ```
def mod_inv(a, b)
  p = b
  x, y, u, v = 1, 0, 0, 1
  while !b.zero?
    k = a // b
    x -= k * u
    y -= k * v
    x, u = u, x
    y, v = v, y
    a, b = b, a % b
  end
  x %= p
  if x < 0
    x += p
  else
    x
  end
end
