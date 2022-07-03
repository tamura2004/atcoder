require "crystal/complex"

enum Road
  Cross
  Tate
  Yoko
  Town
end

class Problem
  getter b : Int64
  getter k : Int64
  getter sz : C
  getter gz : C

  def initialize(@b, @k, @sz, @gz)
  end

  def solve
    ans = (sz - gz).manhattan * k

    each(sz) do |z, zc|
      each(gz) do |w, wc|
        pp! [z, w, zc, wc, dist(z,w)]
        chmin ans, dist(z, w) + zc + wc
      end
    end

    ans
  end

  def dist(z, w)
    cnt = (z - w).manhattan
    case type(z)
    when .tate?
      if type(w).tate?
        if (z // b).imag == (w // b).imag
          d1 = (z.imag % b + w.imag % b) + (z.real - w.real).abs
          d2 = ((b - z.imag % b) + (b - w.imag % b)) + (z.real - w.real).abs
          pp! [d1,d2]
          Math.min d1, d2
        else
          cnt
        end
      else
        cnt
      end
    when .yoko?
      if type(w).yoko?
        if (z // b).real == (w // b).real
          d1 = (z.real % b + w.real % b) * k + (z.imag - w.imag).abs
          d2 = ((b - z.real % b) + (b - w.real % b)) * k + (z.imag - w.imag).abs
          Math.min d1, d2
        else
          cnt
        end
      else
        cnt
      end
    else
      cnt
    end
  end

  def each(z)
    r = 1 + 0.i
    4.times do
      w = z * r
      w = w.imag.i + w.real // b * b
      w *= r.conj
      cost = (z - w).manhattan * k
      yield w, cost
      r *= 1.i
    end
  end

  def type(z)
    c1 = z.real.divisible_by?(b)
    c2 = z.imag.divisible_by?(b)
    case
    when c1 && c2 then Road::Cross
    when c1       then Road::Tate
    when c2       then Road::Yoko
    else               Road::Town
    end
  end
end

t = gets.to_s.to_i64
t.times do
  b, k, sx, sy, gx, gy = gets.to_s.split.map(&.to_i64)
  sz = sy.i + sx
  gz = gy.i + gx
  ans = Problem.new(b, k, sz, gz).solve
  pp ans
end
