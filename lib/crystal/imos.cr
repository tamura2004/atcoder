require "crystal/range_to_tuple"

# イモス法
class IMOS(T)
  getter n : Int32
  getter a : Array(T)
  delegate "[]", "[]=", to: a

  def initialize(@n)
    @a = Array.new(n, T.zero)
  end

  def []=(r : Range(B, E), v : T) forall B, E
    lo, hi = RangeToTuple(Int32).from(r)
    return unless lo < hi
    return unless lo < n
    return unless 0 <= hi
    lo = Math.max(lo, 0)
    a[lo] += v
    return if n <= hi
    a[hi] -= v
  end

  def update!
    (n - 1).times do |i|
      a[i + 1] += a[i]
    end
  end
end
