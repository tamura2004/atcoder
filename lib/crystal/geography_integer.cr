require "crystal/complex"

alias Dot = Complex(Int64)
alias Point = Dot

# 線分
class Segment(P)
  getter a : P
  getter b : P

  def initialize(@a : P, @b : P)
  end

  # 点がabからaを中心に反時計回りにあれば1
  # 直線状にあれば0
  # 時計回りにあれば-1
  def side(v : P)
    (b - a).cross(v - a).sign
  end

  # 直線abから同じ側にあるか
  def same_side?(v : P, u : P)
    side(v) == side(u)
  end

  # 線分上に点があるか
  def includes?(v : P)
    (b - a).cross(v - a).zero? && 
    (v - a).dot(b - a) >= 0 &&
    (v - a).abs2 <= (b - a).abs2
  end
end

alias Seg = Segment

# 三角形
class Triangle(P)
  getter a : P
  getter b : P
  getter c : P
  getter ab : Seg(P)
  getter bc : Seg(P)
  getter ca : Seg(P)

  def initialize(@a : P, @b : P, @c : P)
    @ab = Seg.new(a, b)
    @bc = Seg.new(b, c)
    @ca = Seg.new(c, a)
  end

  # 点が外周を含まず完全に三角形の内部に含まれるか
  def includes?(v : P)
    ab.same_side?(c, v) &&
    bc.same_side?(a, v) &&
    ca.same_side?(b, v)
  end
end

alias Tri = Triangle