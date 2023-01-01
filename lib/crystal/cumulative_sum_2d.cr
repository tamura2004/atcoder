require "crystal/complex"

# 2次元累積和
class CumulativeSum2D(T)
  getter m : Matrix(T)
  getter cs : Matrix(T)

  def initialize(@m : Matrix(T))
    @cs = Matrix(T).zero(@m.z.succ)
    m.z.times do |w|
      cs[w.succ] += cs[w.succ_x] + cs[w.succ_y] - cs[w] + m[w]
    end
  end

  def [](zr : Range(C?, C?))
    z1 = zr.begin || C.zero
    z2 = (zr.excludes_end? ? zr.end : zr.end.try(&.succ)) || m.z
    z3 = z1.y.y + z2.x.x
    z4 = z2.y.y + z1.x.x
    cs[z1] + cs[z2] - cs[z3] - cs[z4]
  end
end

alias CS2D = CumulativeSum2D
