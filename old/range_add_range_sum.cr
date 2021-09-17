require "crystal/segment_tree"

class RangeAddRangeSum
  getter n : Int32
  getter st0 : SegmentTree(Int64)
  getter st1 : SegmentTree(Int64)

  def initialize(@n)
    @st0 = SegmentTree(Int64).new(n)
    @st1 = SegmentTree(Int64).new(n)
  end

  def add(lo, hi, x)
    st0[lo] -= x * (lo - 1)
    st0[hi] += x * (hi - 1)
    st1[lo] += x
    st1[hi] -= x
  end

  def []=(r : Range(Int32, Int32), x : Int64)
    lo = r.begin
    hi = r.end + (r.excludes_end? ? 0 : 1)
    add(lo, hi, x)
  end
  
  def sum(i)
    return 0_i64 if i < 0
    st0[..i] + st1[..i] * i
  end
  
  def sum(lo, hi)
    sum(hi) - sum(lo-1)
  end
  
  def [](r : Range(Int32, Int32)) : Int64
    lo = r.begin
    hi = r.end + (r.excludes_end? ? 0 : 1)
    sum(lo, hi)
  end
end

