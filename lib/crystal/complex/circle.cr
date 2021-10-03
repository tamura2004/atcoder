require "crystal/complex"

struct Circle
  getter c : C
  getter r : Int64

  def initialize(x,y,r)
    @c = C.new x.to_i64, y.to_i64
    @r = r.to_i64
  end

  # 円と円が交差している
  def intersect?(b : self)
    !apart?(b) && !inner?(b)
  end

  # 円周上に点がある
  def intersect?(b : C)
    (c - b).abs2 == r ** 2
  end

  # 円と点を結ぶ線分の最短距離
  def dist(b : C)
    ((c - b).abs - r).abs
  end

  # 円と円が離れている
  def apart?(b : self)
    (c - b.c).abs2 > (r + b.r) ** 2
  end

  # 円が円の内部にある
  def inner?(b : self)
    (c - b.c).abs2 < (r - b.r) ** 2
  end

  # 円と円を結ぶ線分の最短距離
  def dist(b : self)
    return 0_f64 if intersect?(b)

    if apart?(b)
      (c - b.c).abs - r - b.r
    else
      (r - b.r).abs - (c - b.c).abs
    end
  end
end
