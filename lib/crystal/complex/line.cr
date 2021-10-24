require "crystal/complex"

# ax + by + c = 0
struct Line
  getter a : Int64
  getter b : Int64
  getter c : Int64

  # 一次式の係数
  def initialize(a, b, c)
    if a.zero? && b.zero?
      raise "bad parms #{[a, b, c]}"
    end

    a = a.to_i64
    b = b.to_i64
    c = c.to_i64

    if a < 0 || (a.zero? && b < 0)
      a = -a
      b = -b
      c = -c
    end

    gcd = a.gcd(b.gcd(c))
    @a = a // gcd
    @b = b // gcd
    @c = c // gcd
  end

  # 2点を通る直線
  def initialize(x1, y1, x2, y2)
    initialize(y2 - y1, x1 - x2, (x2 - x1)*y1 - (y2 - y1)*x1)
  end

  # 2点を通る直線
  def initialize(z : C, w : C)
    initialize(z.real, z.imag, w.real, w.imag)
  end
end

x = Line.new(0, 0, 1, 2)
y = Line.new(2, -1, 0)

pp! x
pp! y
pp! x == y
