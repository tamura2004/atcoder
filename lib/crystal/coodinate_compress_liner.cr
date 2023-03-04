# => 一括座標圧縮は、indexable.crで実装
#
# 座標圧縮（1次元）計算量 O(N logN)
#
# ```
# cc = CCL.new([100, -10, -10])
# cc << 5
# cc[-10] # => 0
# cc[5] # => 1
# cc[100] # => 2
# ```
class CCL
  getter ready : Bool
  getter src : Array(Int64)
  getter ix : Hash(Int64,Int32)
  getter val : Array(Int64)
  delegate size, to: val

  def initialize
    @ready = false
    @src = [] of Int64
    @val = [] of Int64
    @ix = Hash(Int64,Int32).new
  end
  
  def initialize(a)
    @src = a.map(&.to_i64)
    @val = [] of Int64
    @ready = false
    @ix = Hash(Int64,Int32).new
  end

  def <<(x : Int)
    raise "already commited" if ready
    src << x.to_i64
  end

  def [](x : Int)
    commit! unless ready
    ix[x.to_i64]
  end

  def commit!
    @val = src.sort.uniq
    src.each do |v|
      ix[v] = val.bsearch_index(&.>=(v)).not_nil!
    end
    @ready = true
  end
end
