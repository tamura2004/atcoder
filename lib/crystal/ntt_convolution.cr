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

def pow_mod(x : Int, n : Int, mod : Int) : Int64
  return 0_i64 if mod == 1
  r = 1_i64
  y = (x % mod).to_i64

  while n != 0
    r = (r * y) % mod if n.odd?
    y = (y * y) % mod
    n >>= 1
  end
  return r
end

def well_known_primitive_root(mod : Int) : Int32 | Nil
  case mod
  when         2; 1
  when 167772161; 3
  when 469762049; 3
  when 754974721; 11
  when 998244353; 3
  end
end

def primitive_root(mod : Int) : Int32
  if g = well_known_primitive_root(mod)
    return g
  end

  divs = Array.new(20, 0)
  divs[0] = 2
  cnt = 1
  x = (mod - 1) // 2

  while (x % 2) == 0
    x //= 2
  end

  i = 3
  while i * i <= x
    if x % i == 0
      divs[cnt] = i
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

  (2..).find(-1) do |g|
    cnt.times.all? do |i|
      pow_mod(g, (mod - 1) // divs[i], mod) != 1
    end
  end
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

  # return [s, m0]
  return m0
end

def butterfly_unit(g : Int, mod : Int) : Tuple(Int32, Array(Int64), Array(Int64))
  es = Array.new(30, 0_i64)
  ies = Array.new(30, 0_i64)
  cnt = bsf(mod - 1)
  e = pow_mod(g, (mod - 1) >> cnt, mod)
  ie = inv_gcd(e, mod)
  cnt.downto(2) do |i|
    es[i - 2] = e
    ies[i - 2] = ie
    e *= e
    e %= mod
    ie *= ie
    ie %= mod
  end
  return ({cnt, es, ies})
end

def butterfly_init(g : Int, mod : Int) : Array(Int64)
  cnt, es, ies = butterfly_unit(g, mod)
  se = Array.new(30, 0_i64)
  now = 1_i64
  (cnt - 1).times do |i|
    se[i] = es[i] * now
    se[i] %= mod
    now *= ies[i]
    now %= mod
  end
  return se
end

def butterfly(a : Array(Int64), mod : Int) : Nil
  g = primitive_root(mod)
  n = a.size
  h = ceil_pow2(n)
  se = butterfly_init(g, mod)
  
  1.upto(h) do |ph|
    w = 1_i64 << (ph - 1)
    p = 1_i64 << (h - ph)
    now = 1_i64
    w.times do |s|
      j = s << (h - ph + 1)
      p.times do |i|
        l = a[i + j]
        r = a[i + j + p] * now % mod
        a[i + j] = l + r
        a[i + j + p] = l - r
        a[i + j] %= mod
        a[i + j + p] %= mod
        if a[i + j + p] < 0
          a[i + j + p] += mod
        end
      end
      now *= se[bsf(~s)]
      now %= mod
    end
  end
end

def butterfly_inv_init(g : Int, mod : Int) : Array(Int64)
  sie = Array.new(30, 0_i64)
  cnt2,es,ies = butterfly_unit(g,mod)

  now = 1_i64
  (cnt2 - 1).times do |i|
    sie[i] = ies[i] * now
    sie[i] %= mod
    now *= es[i]
    now %= mod
  end
  sie
end

def butterfly_inv(a : Array(Int64), mod : Int) : Nil
  g = primitive_root(mod)
  n = a.size
  h = ceil_pow2(n)
  first = true
  sie = butterfly_inv_init(g, mod)

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
        a[i + j + p] = (l - r + mod) * inow
        a[i + j] %= mod
        a[i + j + p] %= mod
      end
      inow *= sie[bsf(~s)]
      inow %= mod
    end
  end
end

def convolution_mini(p : Array(Int64), q : Array(Int64), mod : Int) : Array(Int64)
  n = p.size
  m = q.size
  ans = Array.new(n + m - 1, 0_i64)
  p.each_with_index do |a, i|
    q.each_with_index do |b, j|
      ans[i + j] += a * b % mod
      ans[i + j] %= mod
    end
  end
  ans
end

def convolution(p : Array(Int64), q : Array(Int64), mod : Int) : Array(Int64)
  n = p.size
  m = q.size

  return [] of Int64 if n == 0 || m == 0
  return convolution_mini(p,q,mod) if n <= 60 || m <= 60

  z = 1_i64 << ceil_pow2(n + m - 1)
  a = Array.new(z) { |i| i < n ? p[i] : 0_i64 }
  b = Array.new(z) { |i| i < m ? q[i] : 0_i64 }

  butterfly(a, mod)
  butterfly(b, mod)

  z.times do |i|
    a[i] *= b[i]
    a[i] %= mod
  end

  butterfly_inv(a, mod)

  a = a[0, n + m - 1]
  iz = inv_gcd(z, mod)
  (n + m - 1).times do |i|
    a[i] *= iz
    a[i] %= mod
  end
  return a
end
