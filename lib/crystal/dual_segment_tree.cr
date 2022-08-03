require "crystal/range_to_tuple"

# 双対セグ木
#
# 区間更新、１点参照
class DualSegmentTree(T)
  getter n : Int32
  getter r : Int32
  getter a : Array(T)
  getter f : Proc(T, T, T)
  getter unit : T

  # 区間代入
  def self.range_assign(values : Array(T))
    unit = nil.as(T?)
    f = Proc(T?, T?, T?).new { |x, y| y.nil? ? x : y }
    DualSegmentTree(T?).new(values, unit, f)
  end

  # 区間加算
  def self.range_add(values : Array(T))
    unit = T.zero
    f = Proc(T, T, T).new { |x, y| x + y }
    DualSegmentTree(T).new(values, unit, f)
  end

  def initialize(
    values : Array(T),
    @unit = T::MIN,
    @f = Proc(T, T, T).new do |x, y|
      Math.max x, y
    end
  )
    @n = Math.pw2ceil(values.size)
    @r = Math.ilogb(n)
    @a = Array(T).new(n*2, unit)

    values.each_with_index do |v, i|
      a[i + n] = v
    end
  end

  # 遅延適用
  def push_down(i)
    pa = 1
    (0...r).reverse_each do |j|
      lo = pa << 1
      hi = lo | 1
      a[lo] = f.call(a[lo], a[pa])
      a[hi] = f.call(a[hi], a[pa])
      a[pa] = unit
      pa = lo | i.bit(j)
    end
  end

  # １点参照
  def [](i)
    i += n
    push_down(i)
    a[i].not_nil!
  end

  # 区間更新
  def []=(lo, hi, v)
    lo = lo < 0 ? 0 : n < lo ? n : lo
    hi = hi < 0 ? 0 : n < hi ? n : hi
    lo += n
    hi += n
    push_down(lo)
    push_down(hi)

    while lo < hi
      if lo.odd?
        a[lo] = f.call(a[lo], v)
        lo += 1
      end

      if hi.odd?
        hi -= 1
        a[hi] = f.call(a[hi], v)
      end

      lo >>= 1
      hi >>= 1
    end
  end

  def []=(r : Range(B, E), v) forall B, E
    lo, hi = RangeToTuple(Int32).from(r)
    self[lo, hi] = v
  end

  def []=(i : Int32, v)
    self[i, i + 1] = v
  end
end

class Array(T)
  def to_dual_st_add
    DualSegmentTree(T).range_add(self)
  end

  def to_dual_st_assign
    DualSegmentTree(T).range_assign(self)
  end
end
