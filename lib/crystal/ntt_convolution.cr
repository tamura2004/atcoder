MOD = 998244353

def ceil_pow2(n : Int) : Int32
  (0..).find(-1) do |x|
    n <= (1 << x)
  end
end

def bsf(n : Int) : Int32
  (0..).find(-1) do |x|
    (n >> x) & 1 == 1
  end
end

def pow_mod(x : Int, n : Int) : Int64
  return 0_i64 if MOD == 1
  r = 1_i64
  y = (x % MOD).to_i64

  while n != 0
    r = (r * y) % MOD if n.odd?
    y = (y * y) % MOD
    n >>= 1
  end
  return r
end

def inv_gcd(a : Int, b : Int) : Int
  a = a % b

  if a < 0
    a += b
  end

  s, t = b, a
  m0, m1 = 0_i64, 1_i64

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

def butterfly_unit(g : Int) : Tuple(Int32, Array(Int64), Array(Int64))
  es = Array.new(30, 0_i64)
  ies = Array.new(30, 0_i64)
  cnt = bsf(MOD - 1)
  e = pow_mod(g, (MOD - 1) >> cnt)
  ie = inv_gcd(e, MOD)
  cnt.downto(2) do |i|
    es[i - 2] = e
    ies[i - 2] = ie
    e *= e
    e %= MOD
    ie *= ie
    ie %= MOD
  end
  return ({cnt, es, ies})
end

def butterfly_init(g : Int) : Array(Int64)
  cnt, es, ies = butterfly_unit(g)
  se = Array.new(30, 0_i64)
  now = 1_i64
  (cnt - 1).times do |i|
    se[i] = es[i] * now
    se[i] %= MOD
    now *= ies[i]
    now %= MOD
  end
  return se
end

def butterfly(a : Array(Int64)) : Nil
  g = 3
  n = a.size
  h = ceil_pow2(n)
  se = butterfly_init(g)

  1.upto(h) do |ph|
    w = 1_i64 << (ph - 1)
    p = 1_i64 << (h - ph)
    now = 1_i64
    w.times do |s|
      j = s << (h - ph + 1)
      p.times do |i|
        l = a[i + j]
        r = a[i + j + p] * now % MOD
        a[i + j] = l + r
        a[i + j + p] = l - r
        a[i + j] %= MOD
        a[i + j + p] %= MOD
        if a[i + j + p] < 0
          a[i + j + p] += MOD
        end
      end
      now *= se[bsf(~s)]
      now %= MOD
    end
  end
end

def butterfly_inv_init(g : Int) : Array(Int64)
  sie = Array.new(30, 0_i64)
  cnt2,es,ies = butterfly_unit(g)

  now = 1_i64
  (cnt2 - 1).times do |i|
    sie[i] = ies[i] * now
    sie[i] %= MOD
    now *= es[i]
    now %= MOD
  end
  sie
end

def butterfly_inv(a : Array(Int64)) : Nil
  g = 3
  n = a.size
  h = ceil_pow2(n)
  first = true
  sie = butterfly_inv_init(g)

  h.downto(1) do |ph|
    w = 1_i64 << (ph - 1)
    p = 1_i64 << (h - ph)
    inow = 1_i64
    w.times do |s|
      j = s << (h - ph + 1)
      p.times do |i|
        l = a[i + j]
        r = a[i + j + p]
        a[i + j] = l + r
        a[i + j + p] = (l - r + MOD) * inow
        a[i + j] %= MOD
        a[i + j + p] %= MOD
      end
      inow *= sie[bsf(~s)]
      inow %= MOD
    end
  end
end

def convolution(p, q)
  p = p.map(&.to_i64)
  q = q.map(&.to_i64)

  n = p.size
  m = q.size

  return [] of Int64 if n == 0 || m == 0

  z = 1_i64 << ceil_pow2(n + m - 1)
  a = Array.new(z) { |i| i < n ? p[i] : 0_i64 }
  b = Array.new(z) { |i| i < m ? q[i] : 0_i64 }

  butterfly(a)
  butterfly(b)

  z.times do |i|
    a[i] *= b[i]
    a[i] %= MOD
  end

  butterfly_inv(a)

  a = a[0, n + m - 1]
  iz = inv_gcd(z, MOD)
  (n + m - 1).times do |i|
    a[i] *= iz
    a[i] %= MOD
  end
  return a
end
