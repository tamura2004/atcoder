require "crystal/persistent_array"

M = 2_i64 << 20

class PersistentQueue
  getter a : PersistentArray(Int64)
  property lo : Int32
  property hi : Int32

  def initialize(@a = PersistentArray(Int64).new, @lo = 0, @hi = 0)
  end

  def <<(x)
    b = a.update(hi, x)
    self.class.new(b, lo, (hi + 1) % M)
  end

  def shift
    ans = a[lo]
    b = a.update(lo, a[lo])
    {ans, self.class.new(b, (lo + 1) % M, hi)}
  end
end
