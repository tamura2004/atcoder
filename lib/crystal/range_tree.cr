# require "crystal/avl_tree"

# 領域木
#
# 平面上の点の集合に対し矩形領域の個数に答える
class RangeTree
  getter a : Array(Array(Int64))
  getter n : Int32

  def initialize(n)
    @n = Math.pw2ceil(n)
    @a = Array.new(@n*2) { [] of Int64 }
  end

  def query(y1, y2, x1, x2)
    lo = y1 + n
    hi = y2 + n
    ans = 0_i64

    while lo < hi
      ans += count(a[lo], x1, x2) if lo.odd?
      ans += count(a[hi - 1], x1, x2) if hi.odd?
      lo = (lo + 1) // 2
      hi //= 2
    end

    ans
  end

  def count(a : Array(Int64), lo, hi)
    i = a.bsearch_index(&.>= lo) || a.size
    j = a.bsearch_index(&.>= hi) || a.size
    j - i
  end

  alias R = Range(Int::Primitive?, Int::Primitive?)

  def [](yr : R, xr : R)
    y1, y2 = range_to_tuple(yr, n)
    x1, x2 = range_to_tuple(xr, Int64::MAX)
    query(y1, y2, x1, x2)
  end

  def range_to_tuple(r : R, maxi)
    lo = r.begin || 0
    hi = r.end.try &.+(r.excludes_end? ? 0 : 1) || maxi
    {lo, hi}
  end

  def add(y, x)
    i = y + n
    insert a[i], x.to_i64

    while 1 < i
      i //= 2
      insert a[i], x.to_i64
    end
  end

  def insert(a : Array(Int64), v)
    i = a.bsearch_index(&.>= v) || a.size
    a[i,0] = v
  end
end
