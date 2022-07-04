require "crystal/complex"

struct Complex(T)
  def flip
    self.class.new imag, real
  end

  def expand(x)
    self.class.new real * x, imag
  end

  def %(x)
    self.class.new real % x, imag % x
  end

  def **(i)
    ans = 0.i + 1
    i.times do
      ans *= self
    end
    ans
  end

  def floor_real(x)
    expand(x) // x
  end
end

class Problem
  getter b : Int64
  getter k : Int64
  getter sz : C
  getter gz : C
  getter sg : C
  getter gg : C

  def initialize(@b, @k, @sz, @gz)
    @sg = @sz // b
    @gg = @gz // b
  end

  def solve
    return (sz - gz).manhattan if k == 1 || b == 1

    ans = (sz - gz).manhattan * k

    if sg == gg
      4.times do |i|
        z = sz * 1.i ** i % b
        w = gz * 1.i ** i % b
        chmin ans, (z-w).real.abs + z.imag.abs * k + w.imag.abs * k
        # pp! [i,ans,z,w]
      end
    else
      chmin ans, (sz - gz).expand(k).manhattan
      chmin ans, (sz - gz).flip.expand(k).manhattan
    end

    each(sz) do |z, zc|
      each(gz) do |w, wc|
        chmin ans, (z - w).manhattan + zc + wc
      end
    end

    ans
  end

  def each(z)
    4.times do |i|
      r = 1.i ** i
      w = z * r
      cost = {
        (w % b).expand(k).manhattan,
        (w % b).flip.expand(k).manhattan
      }.min
      w = w // b * b
      w *= r.conj
      yield w, cost
    end
  end
end

want = [
  177606591118701316,
6205925075792263,
30320747646118343,
84136273267803188,
83764071874751489,
118960470930399064,
2929499649126153,
16403238161749820,
84995699148879437,
71771264361119335,

]

t = gets.to_s.to_i64
t.times do |i|
  b, k, sx, sy, gx, gy = gets.to_s.split.map(&.to_i64)
  sz = sy.i + sx
  gz = gy.i + gx
  pp Problem.new(b, k, sz, gz).solve # - want[i]
end
