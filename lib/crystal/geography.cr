require "complex"

alias Point = Complex
alias Dot = Complex
EPS = 0.000_000_01_f64

struct Complex
  def self.read
    real, imag = gets.to_s.split.map(&.to_f64)
    new(real, imag)
  end

  def dot(b : self)
    (conj * b).real
  end

  def cross(b : self)
    (conj * b).imag
  end

  def manhattan
    real.abs + imag.abs
  end

  # 自身をaとして
  # a,b,cが反時計回り 1
  # a,b,cが時計回り -1
  # c,a,bがこの順番で同一直線上 2
  # a,b,cがこの順番で同一直線上 -2
  # cが線分ab上にある 0
  def ccw(b : self, c : self)
    x = b - self
    y = c - self
    return 1 if x.cross(y) > EPS
    return -1 if x.cross(y) < -EPS
    return 2 if x.dot(y) < 0
    return -2 if x.abs2 < y.abs2
    return 0
  end

  # 自身をaとして、a,b,cの外心
  def outer_center(b : self, c : self)
    raise "同一直線状であり外心を持ちません" if Line.new(b, c).intersect?(self)
    a = self
    s = (b - a).cross(c - a).abs ** 2 * 4
    x = (b - c).abs2
    y = (a - c).abs2
    z = (a - b).abs2
    (a*x*(y + z - x) + b*y*(z + x - y) + c*z*(x + y - z))/s
  end
end

# 凸包
def convex_hull(dots : Array(Point))
  dots.sort_by!{|z| {z.real, z.imag}}
  up = [] of Point
  dots.each do |dot|
    while up.size >= 2 && (up[-1] - up[-2]).cross(up[-1] - dot) <= 0
      up.pop
    end
    up << dot
  end
  
  dn = [] of Point
  dots.each do |dot|
    while dn.size >= 2 && (dn[-1] - dn[-2]).cross(dn[-1] - dot) >= 0
      dn.pop
    end
    dn << dot
  end

  ans = up + dn[1..-2].reverse
  return {ans, up, dn}
end


# 線分
struct Segment
  getter a : Point
  getter b : Point

  def initialize(@a : Point, @b : Point)
  end

  def initialize(x1, y1, x2, y2)
    initialize(Point.new(x1, y1), Point.new(x2, y2))
  end

  # 線分の交差判定
  def intersect?(t : self) : Bool
    a.ccw(b, t.a) * a.ccw(b, t.b) <= 0 &&
      t.a.ccw(t.b, a) * t.a.ccw(t.b, b) <= 0
  end

  # 線分の交点
  def crosspoint(t : self) : Point
    d1 = (b - a).cross(t.b - t.a)
    d2 = (b - a).cross(b - t.a)
    return t.a if d1.abs < EPS && d2.abs < EPS
    t.a + (t.b - t.a) * (d2 / d1)
  end
end

# 2点a,bを通る直線
struct Line
  getter a : Point
  getter b : Point

  def initialize(@a, @b)
  end

  def ab
    b - a
  end

  # 同一直線
  def same?(t : self)
    intersect?(t.a) && intersect?(t.b)
  end

  # 平行
  def parallel?(t : self)
    ab.cross(t.ab).abs < EPS
  end

  # 交点を持つ（同一直線か、平行でない）
  def intersect?(t : self)
    !parallel?(t) || same?(t)
  end

  # 点が直線上にある
  def intersect?(t : Point)
    (t - a).cross(t - b).abs < EPS
  end

  # 2直線の交点
  def crosspoint(t : self)
    return a if t.intersect?(a)
    return b if t.intersect?(b)
    return t.a if intersect?(t.a)
    return t.b if intersect?(t.b)
    raise "平行であり交点を持ちません" if parallel?(t)

    x = ab.cross(t.ab)
    y = ab.cross(b - t.a)

    t.a + y / x * t.ab
  end

  # 垂直二等分線
  def virtical_bisector
    x = (a + b) / 2
    y = x + ab * 1.i
    Line.new(x, y)
  end
end

# 円
struct Circle
  getter c : Point   # 中心
  getter r : Float64 # 半径

  def initialize(@c, r)
    @r = r.to_f64
  end

  def initialize(x, y, @r)
    @c = Point.new(x, y)
  end

  # 点が円に含まれる
  def includes?(t : Point)
    (t - c).abs < r + EPS
  end

  # 2つの円の交差判定
  # 戻り値は共通接線の数
  def intersect?(t : Circle)
    d = (c - t.c).abs
    return 4 if r + t.r + EPS < d             # 離れている
    return 3 if ((r + t.r).abs - d).abs < EPS # 外接している
    return 1 if ((r - t.r).abs - d).abs < EPS # 外接している
    return 0 if d < (r - t.r).abs - EPS       # 内包している
    return 2                                  # 交差している
  end

  def cross_point(t : Circle)
    ans = [] of Point
    d = (c - t.c).abs
    case intersect?(t)
    when 0,4
    when 3
      ans << (c * t.r + t.c * r) / (r * t.r)
    when 1
      if t.r < r - EPS
        ans << c + (t.c - c) * (r / d)
      else
        ans << t.c + (c - t.c) * (t.r / d)
      end
    when 2
      rc1 = (r * r + d * d - t.r * t.r) / (d * 2)
      rs1 = Math.sqrt((r * r - rc1 * rc1).abs)
      rs1 = 0.0 if (r - rc1.abs) < EPS
      e12 = (t.c - c) / (t.c - c).abs
      ans << c + rc1 * e12 + rs1 * e12 * Point.new(0, 1)
      ans << c + rc1 * e12 + rs1 * e12 * Point.new(0, -1)
    else
      raise "circle intersect error"
    end
    ans
  end
end

# sx,sy,gx,gy = gets.to_s.split.map(&.to_f64)
# a = Segment.new(sx,0,gx,0)
# b = Segment.new(sx,sy,gx,-gy)
# pp a.cross_point(b).real
