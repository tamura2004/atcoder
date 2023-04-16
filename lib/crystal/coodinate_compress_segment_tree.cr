require "crystal/cc"
require "crystal/range_to_tuple"

class CoodinateCompressSegmentTree(K, V)
  getter n : Int32
  getter cc : CC(K)
  getter a : Array(V)
  getter unit : V
  getter fx : Proc(V, V, V)

  def initialize(keys : Array(K), @unit : V, &@fx : Proc(V, V, V))
    @cc = keys.to_cc
    @n = Math.pw2ceil(cc.size)
    @a = Array.new(n*2, unit)
  end

  def update(k, v)
    i = cc[k] + n
    a[i] = v
    while 1 < i
      i >>= 1
      a[i] = fx.call a[i*2 + 1], a[i*2]
    end
  end

  def []=(k, v)
    update(k, v)
  end

  def query(lo, hi)
    lo += n
    hi += n
    left = right = unit

    while lo < hi
      if lo.odd?
        left = fx.call left, a[lo]
        lo += 1
      end

      if hi.odd?
        hi -= 1
        right = fx.call a[hi], right
      end

      lo >>= 1
      hi >>= 1
    end

    fx.call left, right
  end

  def [](k : K)
    return unit unless cc.has_key?(k)
    a[cc[k] + n]? || unit
  end

  def [](r)
    lo, hi = cc.range_to_tuple(r)
    query(lo, hi)
  end

  def inspect(io)
    io << cc.ref
    5.times do |h|
      io << a[2**h...2**(h+1)].join(" ")
      io << "\n"
    end
  end
end

alias CCST = CoodinateCompressSegmentTree

class Array(T)
  def to_ccst_sum
    CCST(T, Int64).new(keys: self, unit: 0_i64) { |x, y| x + y }
  end
end
