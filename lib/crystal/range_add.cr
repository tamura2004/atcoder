require "crystal/segment_tree"

# 範囲加算、一点読み出し
class RangeAdd
  getter st : ST

  def initialize(n)
    @st = ST.sum(n)
  end

  def []=(i : Int, v : Int)
    i = i.to_i
    v = v.to_i64

    st[i] += v
    st[i+1] -= v
  end

  def [](i : Int)
    i = i.to_i

    st[..i]
  end

  def []=(r : Range(Int,Int), v)
    lo = r.begin
    hi = r.end + (r.excludes_end? ? 0 : 1)
    st[lo] += v
    st[hi] -= v
  end

  def []=(lo : Int, size : Int, v)
    lo = lo.to_i
    size = size.to_i

    hi = lo + size - 1
    self[lo..hi] = v
  end
end