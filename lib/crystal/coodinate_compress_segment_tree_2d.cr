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

  def inspect
    cc.ref.to_s + ":" + a.join(" ")
  end
end

alias CCST = CoodinateCompressSegmentTree

class CoodinateCompressSegmentTree2d(K, V)
  getter unit : V
  getter fx : Proc(V, V, V)
  getter cc : CC(K)
  getter n : Int32
  getter a : Array(CCST(K, V))

  def initialize(keys : Array(Tuple(K, K)), @unit : V, &@fx : Proc(V, V, V))
    @cc = keys.map(&.first).to_cc
    @n = Math.pw2ceil(cc.size)
    xs = Array.new(n*2) { [] of K }
    keys.each do |y, x|
      i = cc[y] + n
      while i > 0
        xs[i] << x
        i >>= 1
      end
    end
    @a = Array.new(n*2) do |i|
      CCST(K, V).new(
        keys: xs[i],
        unit: unit
      ) { |x, y| fx.call x, y }
    end
  end

  def update(y, x, v)
    i = cc[y] + n
    a[i][x] = v
    while 1 < i
      i >>= 1
      a[i][x] = fx.call a[i*2][x], a[i*2 + 1][x]
    end
  end

  def []=(y, x, v)
    update(y, x, v)
  end

  def query(lo, hi, r)
    lo += n
    hi += n
    left = right = unit
    while lo < hi
      if lo.odd?
        left = fx.call left, a[lo][r]
        lo += 1
      end
      if hi.odd?
        hi -= 1
        right = fx.call a[hi][r], right
      end
      lo >>= 1
      hi >>= 1
    end
    fx.call left, right
  end

  def [](y : Int, x : Int)
    i = cc[y] + n
    a[i][x]
  end

  def [](r1, r2)
    lo, hi = cc.range_to_tuple(r1)
    query(lo, hi, r2)
  end

  def inspect
    a.map(&.inspect).join("\n")
  end
end

alias CCST2D = CoodinateCompressSegmentTree2d
