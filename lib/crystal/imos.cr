require "crystal/range_to_tuple"

# イモス法
class IMOS(T)
  getter n : Int32
  getter a : Array(T)
  private getter updated : Bool

  def initialize(@n)
    @a = Array.new(n, T.zero)
    @updated = false
  end

  def [](i : Int)
    raise "参照前にupdate!メソッドの呼び出しが必要です" unless @updated
    a[i]
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

  # 参照前に必須
  def update!
    @updated = true
    (n - 1).times do |i|
      a[i + 1] += a[i]
    end
  end
end
