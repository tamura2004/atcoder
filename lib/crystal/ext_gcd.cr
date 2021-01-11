# 拡張ユークリッド互除法
# ax + by = gcd(a,b) = gを解く
#
# ```
# 3x + 7y = 1 # => x = -2, y = 1, g = 1
# ```
def ext_gcd(a, b)
  x, y, u, v = 1, 0, 0, 1
  while !b.zero?
    k = a // b
    x -= k * u
    y -= k * v
    x, u = u, x
    y, v = v, y
    a, b = b, a % b
  end
  return x, y
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
