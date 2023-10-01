require "crystal/cc"
require "crystal/st"

class CoodinateCompressSegmentTree(K, V)
  getter cc : CC(K)
  getter st : SegmentTree(V)

  def initialize(keys : Array(K), fxx)
    @cc = CC.new(keys)
    n = cc.size
    values = Array.new(n, nil.as(V?))
    @st = SegmentTree(V).new(values, fxx)
  end

  def []=(k : K, v : V)
    @st[cc[k]] = v
  end

  def [](i)
    @st[i]
  end

  def []?(i)
    @st[i]?
  end

  def [](r : Range(B, E)) forall B, E
    lo = r.begin.try { |b| @cc.round_up(b) } || cc.ref[0]
    hi = r.end.try { |e| @cc.round_down(e, r.excludes_end?) } || cc.ref[-1]
    @st[cc[lo]..cc[hi]]
  end
end

alias CCST = CoodinateCompressSegmentTree

class Array(T)
  def to_ccst_sum
    CCST(T, Int64).new(
      keys: self,
      fxx: ->(x : Int64, y : Int64) { x + y }
    )
  end
end
