# 区間和セグメント木
class RangeSum(T)
  getter n : Int32
  getter a : Array(T)

  def initialize(_n)
    @n = Math.pw2ceil(_n)
    @a = Array.new(@n * 2) { T.zero }
  end

  def set(i, x)
    i += n
    a[i] = x
    while i > 1
      i >>= 1
      a[i] = a[i * 2] + a[i * 2 + 1]
    end
  end

  def []=(i, x)
    set(i, x)
  end

  def get(i)
    a[i + n]
  end

  def [](i)
    get(i)
  end

  def query(lo, hi)
    lo += n
    hi += n
    acc = T.zero
    while lo < hi
      if lo.odd?
        acc += a[lo]
        lo += 1
      end
      if hi.odd?
        hi -= 1
        acc += a[hi]
      end
      lo >>= 1
      hi >>= 1
    end
    acc
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?))
    lo = (r.begin || 0).clamp(0..n-1)
    hi = (r.end.try(&.+(1).-(r.excludes_end?.to_unsafe)) || n).clamp(0..n)
    query(lo, hi)
  end

  def to_a
    a[n, n]
  end
end

struct Int
  def to_st_sum
    RangeSum(Int64).new(self)
  end
end
