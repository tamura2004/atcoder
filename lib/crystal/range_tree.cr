# 領域木
#
# 平面上の重み付き点の集合に対し矩形領域のクエリに答える
class RangeTree
  alias Point = Tuple(Int32, Int32, Int64)
  getter seg : Array(Array(Int32))
  getter sum : Array(Array(Int64))
  getter a : Array(Int32)
  getter size : Int32

  def initialize(v : Array(Point))
    v.sort!
    @a = v.map(&.[0]).uniq
    @size = 1

    while size < a.size
      @size <<= 1
    end

    while a.size < size
      @a << Int32::MAX // 2
    end

    @seg = Array.new(size * 2) { [] of Int32 }
    @sum = Array.new(size * 2) { [] of Int64 }

    i = 0
    v.each do |x, y, v|
      if a[i] != x
        i += 1
      end

      seg[i + size] << y
      sum[i + size] << v
    end

    (1...size).reverse_each do |i|
      l = r = 0
      while l < seg[i*2].size || r < seg[i*2 + 1].size
        f = case
            when r >= seg[i*2 + 1].size        then true
            when l >= seg[i*2].size            then false
            when seg[i*2][l] < seg[i*2 + 1][r] then true
            else                                    false
            end

        if f
          seg[i] << seg[i*2][l]
          sum[i] << sum[i*2][l]
          l += 1
        else
          seg[i] << seg[i*2 + 1][r]
          sum[i] << sum[i*2 + 1][r]
          r += 1
        end
      end

      (1...size*2).each do |i|
        replace = Array.new(1, 0_i64)
        sum[i].each do |val|
          replace << replace[-1] + val
        end
        sum[i], replace = replace, sum[i]
      end
    end
  end

  def query(x1, y1, x2, y2)
    l = a.bsearch_index(&.>= x1) || a.size
    r = a.bsearch_index(&.>= x2) || a.size
    l += size
    r += size
    ret = 0_i64

    while l < r
      if l.odd?
        hi = seg[l].bsearch_index(&.>= y2) || seg[l].size
        lo = seg[l].bsearch_index(&.>= y1) || seg[l].size
        begin
          ret += sum[l][hi] - sum[l][lo]
        rescue
          pp! [x1, y1, x2, y2]
          pp! [l, r, lo, hi]
          pp! sum[l]
          pp! self
          exit
        end
        l += 1
      end

      if r.odd?
        r -= 1
        hi = seg[r].bsearch_index(&.>= y2) || seg[r].size
        lo = seg[r].bsearch_index(&.>= y1) || seg[r].size
        ret += sum[r][hi] - sum[r][lo]
      end
      l >>= 1
      r >>= 1
    end
    ret
  end

  alias R = Range(Int::Primitive?, Int::Primitive?)

  def [](xr : R, yr : R)
    x1 = xr.begin || 0
    x2 = (xr.end || a.size - 1) + (xr.excludes_end? ? 0 : 1)
    y1 = yr.begin || 0
    y2 = (yr.end || seg.size - 1) + (yr.excludes_end? ? 0 : 1)
    query(x1, y1, x2, y2)
  end
end
