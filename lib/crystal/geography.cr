require "complex"

alias Point = Complex
EPS = 0.000_000_01_f64

struct Complex

  def dot(b : self)
    (conj * b).real
  end

  def cross(b : self)
    (conj * b).imag
  end

  def manhattan
    real.abs + imag.abs
  end

  def ccw(b : self, c : self)
    x = b - self
    y = c - self
    return 1 if x.cross(y) > EPS
    return -1 if x.cross(y) < -EPS
    return 2 if x.dot(y) < 0
    return -2 if x.abs2 < y.abs2
    return 0
  end
end

# 線分
struct Segment
  getter a : Point
  getter b : Point

  def initialize(@a : Point, @b : Point)
  end

  def initialize(x1,y1,x2,y2)
    initialize(Point.new(x1,y1), Point.new(x2,y2))
  end

  # 線分の交差判定
  def intersect?(t : self) : Bool
    a.ccw(b, t.a) * a.ccw(b, t.b) <= 0 &&
    t.a.ccw(t.b, a) * t.a.ccw(t.b, b) <= 0
  end

  # 線分の交点
  def cross_point(t : self) : Point
    d1 = (b - a).cross(t.b - t.a)
    d2 = (b - a).cross(b - t.a)
    return t.a if d1.abs < EPS && d2.abs < EPS
    t.a + (t.b - t.a) * (d2 / d1)
  end
end

# sx,sy,gx,gy = gets.to_s.split.map(&.to_f64)
# a = Segment.new(sx,0,gx,0)
# b = Segment.new(sx,sy,gx,-gy)
# pp a.cross_point(b).real


