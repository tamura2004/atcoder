# @param n `0 <= n`
# @return minimum non-negative `x` s.t. `n <= 2**x`
def ceil_pow2(n : Int) : Int
  (0..).find(-1) do |x|
    n <= (1 << x)
  end
end

# @param n `1 <= n`
# @return minimum non-negative `x` s.t. `(n & (1 << x)) != 0`
def bsf(n : Int) : Int
  (0..).find(-1) do |x|
    (n >> x) & 1 == 1
  end
end

def pow_mod(x, n, m)
  return 0_i64 if m == 1
  r = 1_i64
  y = x.to_i64 % m

  while n != 0
    r = (r * y) % m if (n & 1) == 1
    y = (y * y) % m
    n >>= 1
  end
  return r
end

def primitiveRoot(m : Int64)
  if m == 2
    return 1
  elsif m == 167772161
    return 3
  elsif m == 469762049
    return 3
  elsif m == 754974721
    return 11
  elsif m == 998244353
    return 3
  end

  divs = Array.new(20, 0_i64)
  divs[0] = 2_i64
  cnt = 1
  x = (m - 1) // 2

  while (x % 2) == 0
    x //= 2
  end

  i = 3
  while i * i <= x
    if x % i == 0
      divs[cnt] = i.to_i64
      cnt += 1
      while x % i == 0
        x //= i
      end
    end
    i += 2
  end

  if x > 1
    divs[cnt] = x
    cnt += 1
  end

  g = 2
  loop do
    ok = true
    cnt.times do |i|
      if pow_mod(g, (m - 1) // divs[i], m) == 1
        ok = false
        break
      end
    end
    if ok
      return g
    end
    g += 1
  end
end

def inv_gcd(a, b)
  a = a % b

  if a < 0
    a += b
  end

  s, t = b, a
  m0, m1 = 0, 1

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

  # return [s, m0]
  return m0.to_i64
end

def butterfly(a, prm)
  g = primitiveRoot(prm)
  n = a.size
  h = ceil_pow2(n)
  first = true
  se = Array.new(30, 0_i64)
  if first
    first = false
    es = Array.new(30, 0_i64)
    ies = Array.new(30, 0_i64)
    cnt2 = bsf(prm - 1)
    e = pow_mod(g, (prm - 1) >> cnt2, prm)
    ie = inv_gcd(e, prm)

    cnt2.downto(2) do |i|
      es[i - 2] = e
      ies[i - 2] = ie
      e *= e
      e %= prm
      ie *= ie
      ie %= prm
    end

    now = 1_i64
    (cnt2 - 1).times do |i|
      se[i] = es[i] * now
      se[i] %= prm
      now *= ies[i]
      now %= prm
    end
  end

  1.upto(h) do |ph|
    w = 1_i64 << (ph - 1)
    p = 1_i64 << (h - ph)
    now = 1_i64
    w.times do |s|
      offset = s << (h - ph + 1)
      p.times do |i|
        l = a[i + offset]
        begin
          r = a[i + offset + p] * now % prm
        rescue
          pp! n
          pp! h
          pp! i
          pp! offset
          pp! p
          pp! a.size
          pp! i + offset + p
          exit
        end
        a[i + offset] = l + r
        a[i + offset + p] = l - r
        a[i + offset] %= prm
        a[i + offset + p] %= prm
        if a[i + offset + p] < 0
          a[i + offset + p] += prm
        end
      end
      now *= se[bsf(~s)]
      now %= prm
    end
  end
end

def butterflyInv(a, prm)
  g = primitiveRoot(prm)
  n = a.size
  h = ceil_pow2(n)
  first = true
  sie = Array.new(30, 0_i64)
  if first
    first = false
    es = Array.new(30, 0_i64)
    ies = Array.new(30, 0_i64)

    cnt2 = bsf(prm - 1)
    e = pow_mod(g, (prm - 1) >> cnt2, prm)
    ie = inv_gcd(e, prm)
    cnt2.downto(2) do |i|
      es[i - 2] = e
      ies[i - 2] = ie
      e *= e
      e %= prm
      ie *= ie
      ie %= prm
    end
    now = 1_i64
    (cnt2 - 1).times do |i|
      sie[i] = ies[i] * now
      sie[i] %= prm
      now *= es[i]
      now %= prm
    end
  end

  h.downto(1) do |ph|
    w = 1_i64 << (ph - 1)
    p = 1_i64 << (h - ph)
    inow = 1_i64
    w.times do |s|
      offset = s << (h - ph + 1)
      p.times do |i|
        l = a[i + offset]
        r = a[i + offset + p]
        a[i + offset] = l + r
        a[i + offset + p] = (prm + l - r) * inow
        a[i + offset] %= prm
        a[i + offset + p] %= prm
      end
      inow *= sie[bsf(~s)]
      inow %= prm
    end
  end
end

def convolution(p, q, prm)
  n = p.size
  m = q.size
  return [] of Int64 if n == 0 || m == 0

  if [n, m].min <= 60
    if n < m
      n, m = m, n
      p, q = q, p
    end
    a = p.dup
    b = q.dup
    ans = Array.new(n + m - 1, 0_i64)
    n.times do |i|
      m.times do |j|
        ans[i + j] += a[i] * b[j] % prm
        ans[i + j] %= prm
      end
    end
    return ans
  end

  z = 1_i64 << ceil_pow2(n + m - 1)
  a = Array.new(z) { |i| i < n ? p[i] : 0_i64 }
  b = Array.new(z) { |i| i < m ? q[i] : 0_i64 }

  butterfly(a, prm)
  butterfly(b, prm)

  z.times do |i|
    a[i] *= b[i]
    a[i] %= prm
  end

  butterflyInv(a, prm)

  a = a[0, n + m]
  iz = inv_gcd(z, prm)
  (n + m).times do |i|
    a[i] *= iz
    a[i] %= prm
  end
  return a
end

MOD = 998244353_i64
n,m = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i64 }
b = gets.to_s.split.map { |v| v.to_i64 }
puts convolution(a, b, MOD).join(" ")

include Random::Secure
N = 500000
10.times do
  a = Array.new(100){ rand(0_i64..MOD-1) }
  b = Array.new(100){ rand(0_i64..MOD-1) }
  pp! convolution(a, b, MOD)[0,10]
end

