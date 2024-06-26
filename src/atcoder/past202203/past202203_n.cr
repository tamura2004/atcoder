struct NTT(M, G)
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
    return 0_i64 if M == 1
    r = 1_i64
    y = (x % M).to_i64

    while n != 0
      r = (r * y) % M if n.odd?
      y = (y * y) % M
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

  def butterfly_unit
    es = Array.new(30, 0_i64)
    ies = Array.new(30, 0_i64)
    cnt = bsf(M - 1)
    e = pow_mod(G, (M - 1) >> cnt)
    ie = inv_gcd(e, M)
    cnt.downto(2) do |i|
      es[i - 2] = e
      ies[i - 2] = ie
      e *= e
      e %= M
      ie *= ie
      ie %= M
    end
    return ({cnt, es, ies})
  end

  def butterfly_init
    cnt, es, ies = butterfly_unit
    se = Array.new(30, 0_i64)
    now = 1_i64
    (cnt - 1).times do |i|
      se[i] = es[i] * now
      se[i] %= M
      now *= ies[i]
      now %= M
    end
    return se
  end

  def butterfly(a : Array(Int64)) : Nil
    n = a.size
    h = ceil_pow2(n)
    se = butterfly_init

    1.upto(h) do |ph|
      w = 1_i64 << (ph - 1)
      p = 1_i64 << (h - ph)
      now = 1_i64
      w.times do |s|
        j = s << (h - ph + 1)
        p.times do |i|
          l = a[i + j]
          r = a[i + j + p] * now % M
          a[i + j] = l + r
          a[i + j + p] = l - r
          a[i + j] %= M
          a[i + j + p] %= M
          if a[i + j + p] < 0
            a[i + j + p] += M
          end
        end
        now *= se[bsf(~s)]
        now %= M
      end
    end
  end

  def butterfly_inv_init
    sie = Array.new(30, 0_i64)
    cnt2, es, ies = butterfly_unit

    now = 1_i64
    (cnt2 - 1).times do |i|
      sie[i] = ies[i] * now
      sie[i] %= M
      now *= es[i]
      now %= M
    end
    sie
  end

  def butterfly_inv(a : Array(Int64)) : Nil
    n = a.size
    h = ceil_pow2(n)
    first = true
    sie = butterfly_inv_init

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
          a[i + j + p] = (l - r + M) * inow
          a[i + j] %= M
          a[i + j + p] %= M
        end
        inow *= sie[bsf(~s)]
        inow %= M
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
      a[i] %= M
    end

    butterfly_inv(a)

    a = a[0, n + m - 1]
    iz = inv_gcd(z, M)
    (n + m - 1).times do |i|
      a[i] *= iz
      a[i] %= M
    end
    return a
  end

  def conv(p, q)
    convolution(p, q)
  end
end

module Convolution2
  extend self

  M1 =   167_772_161_i64
  M2 =   469_762_049_i64
  M3 = 1_224_736_769_i64

  def solve(a, b, mod)
    x = NTT(M1, 3).new.conv(a, b)
    y = NTT(M2, 3).new.conv(a, b)
    z = NTT(M3, 3).new.conv(a, b)

    [x, y, z].transpose.map do |a|
      garner([M1, M2, M3].zip(a), mod)
    end
  end

  def inv(a, b)
    p = b.to_i64
    x, y, u, v = 1_i64, 0_i64, 0_i64, 1_i64
    while b > 0
      k = a // b
      x -= k * u
      y -= k * v
      x, u, y, v, a, b = u, x, v, y, b, a % b
    end
    x % p
  end

  def mod_add(a, b, mod)
    (a + b) % mod
  end

  def mod_mul(a, b, mod)
    (a * b) % mod
  end

  def garner(ma, mod)
    ar = 0_i64
    mr = 1_i64

    ma.each do |m, a|
      ar = mod_mul(mod_mul(mod_add(ar, mr, mod), inv(mr, m), mod), a - ar, mod)
      mr = (mr * m) % mod
    end
    ar % mr
  end
end

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

if n < m
  while a.size < m
    a << 0_i64
  end
else
  while b.size < n
    b << 0_i64
  end
end

puts Convolution2.solve(a, b, 1_000_000_007_i64)
