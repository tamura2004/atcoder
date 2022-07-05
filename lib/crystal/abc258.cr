require "crystal/complex"

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end


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

module Abc258
  enum P
    Cross
    Tate
    Yoko
    Other
  end

  enum D
    Up
    Down
    Right
    Left
  end

  struct F
    getter b : Int64
    getter k : Int64

    def initialize(@b, @k)
    end

    def pos(z)
      case
      when z % b == 0.i    then P::Cross
      when z.real % b == 0 then P::Tate
      when z.imag % b == 0 then P::Yoko
      else                      P::Other
      end
    end

    def street(z, d)
      case d
      when .up?
        i = (z.imag + b - 1) // b * b
        C.new z.real, i
      when .down?
        i = z.imag // b * b
        C.new z.real, i
      when .right?
        r = (z.real + b - 1) // b * b
        C.new r, z.imag
      else
        r = z.real // b * b
        C.new r, z.imag
      end
    end

    def crosses(z)
      case pos(z)
      when .cross? then [{z, 0_i64}]
      when .other? then [] of Tuple(C, Int64)
      when .tate?
        [D::Up, D::Down].map do |d|
          w = street(z, d)
          cost = (w - z).manhattan
          {w, cost}
        end
      else
        [D::Right, D::Left].map do |d|
          w = street(z, d)
          cost = (w - z).manhattan
          {w, cost}
        end
      end
    end

    def streets(z)
      return [{z, 0_i64}] unless pos(z).other?

      ans = [] of {C, Int64}
      D.each do |d|
        w = street(z, d)
        cost = (w - z).manhattan * k
        ans << {w, cost}
      end
      ans
    end

    def dist(s, g)
      ans = (s - g).manhattan * k
      streets(s).each do |z, cz|
        streets(g).each do |w, cw|
          chmin ans, dist_between_street(z, w) + cz + cw
        end
      end
      ans
    end

    def dist_between_street(s, g)
      z = s // b
      w = g // b
      ans = Int64::MAX

      if z == w
        chmin ans, (s - g).manhattan
      elsif pos(s) == pos(g) == P::Tate && (z - w).imag.zero?
        chmin ans, (s - g).real.abs * k + (s - g).imag.abs
      elsif pos(s) == pos(g) == P::Yoko && (z - w).real.zero?
        chmin ans, (s - g).real.abs + (s - g).imag.abs * k
      else
        chmin ans, (s - g).manhattan
      end

      crosses(s).each do |z, cz|
        crosses(g).each do |w, cw|
          chmin ans, (z - w).manhattan + cz + cw
        end
      end

      ans
    end
  end
end
