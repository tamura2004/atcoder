require "crystal/range_to_tuple"

# 2次元累積和
class CumulativeSum2D(T)
  getter h : Int32
  getter w : Int32
  getter cs : Array(Array(T))

  def initialize(a : Array(Array(T)))
    @h = a.size
    @w = a[0].size
    @cs = Array.new(h + 1) { Array.new(w + 1, T.zero) }

    h.times do |i|
      w.times do |j|
        cs[i + 1][j + 1] += cs[i + 1][j] + cs[i][j + 1] - cs[i][j] + a[i][j]
      end
    end
  end

  # 半開区間[x1,x2)[y1,y2)の範囲の合計
  def sum(y1, x1, y2, x2)
    y1 = Math.max(0, y1)
    y2 = Math.min(h, y2)
    x1 = Math.max(0, x1)
    x2 = Math.min(w, x2)
    cs[y2][x2] - cs[y2][x1] - cs[y1][x2] + cs[y1][x1]
  end

  # 区間指定
  def [](yr : Range(B, E), xr : Range(B, E)) forall B, E
    y1, y2 = RangeToTuple(Int32).from(yr)
    x1, x2 = RangeToTuple(Int32).from(xr)
    sum(y1, x1, y2, x2)
  end
end

alias CS2D = CumulativeSum2D
