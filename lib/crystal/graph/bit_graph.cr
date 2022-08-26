require "crystal/graph/i_graph"
require "crystal/graph/i_bit_graph"

class BitGraph
  include IBitGraph

  getter n : Int32
  getter m : Int32
  getter both : Bool
  getter g : Array(Int64)

  def initialize(n)
    raise "超点数 #{n} が64を超過" if n > 64
    @n = n
    @m = 0
    @both = true
    @g = Array.new(n, 0_i64)
  end

  def add(v, nv, origin = 1, both = false)
    @both = both
    @m += 1
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] |= 1_i64 << nv
    g[nv] |= 1_i64 << v if both
  end

  def each(&b : Int32 -> _)
    n.times do |v|
      b.call v
    end
  end

  def each(v : Int32, &b : Int32 -> _)
    n.times do |nv|
      b.call nv if v.bit(nv) == 1
    end
  end

  def mask(v : Int32) : Int64
    g[v]
  end
end
