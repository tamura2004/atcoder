require "crystal/range_to_tuple"

# 2次元累積和
#
# 値を追加しながら範囲和を取れる
# ただし、範囲が全て更新済であり、更新順が調蜜であること
class CS2D(T)
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(T))

  def initialize(h, w)
    @h = h.to_i
    @w = w.to_i
    @a = Array.new(@h+1) do 
      Array.new(@w+1) do
        T.zero
      end
    end
  end

  def []=(y, x, v)
    a[y+1][x+1] = a[y][x+1] + a[y+1][x] - a[y][x] + v
  end

  def [](y1, y2, x1, x2)
    a[y2][x2] - a[y1][x2] - a[y2][x1] + a[y1][x1]
  end

  def [](y, x)
    y1, y2 = RangeToTuple(Int32).from(y, min: 0, max: h)
    x1, x2 = RangeToTuple(Int32).from(x, min: 0, max: w)
    self[y1,y2,x1,x2]
  end
end
