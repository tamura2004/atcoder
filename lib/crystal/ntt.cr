require "crystal/modint9"

struct NTT
  class_getter se : Array(ModInt) = butterfly_init(ROOT)
  class_getter sie : Array(ModInt) = butterfly_inv_init(ROOT)

  def self.butterfly_unit(g)
    cnt = (MOD - 1).trailing_zeros_count
    es = Array.new(cnt, 0.to_m)
    ies = Array.new(cnt, 0.to_m)
    e = g.pow((MOD - 1) >> cnt)
    ie = e.inv
    cnt.downto(2) do |i|
      es[i - 2] = e
      ies[i - 2] = ie
      e *= e
      ie *= ie
    end
    {cnt, es, ies}
  end

  def self.butterfly_init(g)
    cnt, es, ies = butterfly_unit(g)
    se = Array.new(cnt, 0.to_m)
    now = 1.to_m
    (cnt - 1).times do |i|
      se[i] = es[i] * now
      now *= ies[i]
    end
    se
  end

  def self.butterfly_inv_init(g)
    cnt, es, ies = butterfly_unit(g)
    sie = Array.new(cnt, 0.to_m)

    now = 1.to_m
    (cnt - 1).times do |i|
      sie[i] = ies[i] * now
      now *= es[i]
    end
    sie
  end

  def self.butterfly(a) : Nil
    n = a.size
    h = Math.ilogb(Math.pw2ceil(n))

    1.upto(h) do |ph|
      w = 1_i64 << (ph - 1)
      p = 1_i64 << (h - ph)
      now = 1.to_m
      w.times do |s|
        j = s << (h - ph + 1)
        p.times do |i|
          l = a[i + j]
          r = a[i + j + p] * now
          a[i + j] = l + r
          a[i + j + p] = l - r
        end
        now *= se[(~s).trailing_zeros_count]
      end
    end
  end

  def self.butterfly_inv(a)
    n = a.size
    h = Math.ilogb(Math.pw2ceil(n))

    h.downto(1) do |ph|
      w = 1_i64 << (ph - 1)
      p = 1_i64 << (h - ph)
      inow = 1.to_m
      w.times do |s|
        j = s << (h - ph + 1)
        p.times do |i|
          l = a[i + j]
          r = a[i + j + p]
          a[i + j] = l + r
          a[i + j + p] = (l - r) * inow
        end
        inow *= sie[(~s).trailing_zeros_count]
      end
    end
  end

  def self.conv(p, q) : Array(ModInt)
    a = p.map(&.to_m)
    b = q.map(&.to_m)

    n = a.size
    m = b.size

    return [] of ModInt if n == 0 || m == 0

    z = Math.pw2ceil(n + m - 1)
    while a.size < z
      a << 0.to_m
    end

    while b.size < z
      b << 0.to_m
    end

    butterfly(a)
    butterfly(b)

    z.times do |i|
      a[i] *= b[i]
    end

    butterfly_inv(a)

    iz = z.to_m.inv
    (n + m - 1).times do |i|
      a[i] *= iz
    end

    a.first(n + m - 1)
  end
end
