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
  return x, y, a
end

require "big"

# 中国剰余定理
# 連立合同式を解く
def crt(b1, m1, b2, m2)
  d = m1.gcd(m2)
  p, q = ext_gcd(m1, m2)
  return nil if (b2 - b1) % d != 0
  s = ((b2 - b1) // d)
  begin
    ans = (s * p * m1 + b1) % m1.lcm(m2)
  rescue
    pp! [b1,m1,b2,m2]
    exit
  end
  return ans
end

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

def solve(x, y, p, q)
  # min crt(b1,m1,b2,m2)
  # m1 = (x+y)*2
  # m2 = p+q
  # b1 <- [x, x+y) mod m1
  # b2 <- [p, p+q) mod m2
  m1 = (x + y) * 2
  m2 = p + q
  ans = Int64::MAX
  (x...(x + y)).each do |b1|
    (p...(p + q)).each do |b2|
      if cnt = crt(b1, m1, b2, m2)
        chmin ans, cnt
      end
    end
  end
  ans == Int64::MAX ? "infinity" : ans
end

n = gets.to_s.to_i
n.times do
  x, y, p, q = gets.to_s.split.map { |v| v.to_i64 }
  puts solve(x, y, p, q)
end
