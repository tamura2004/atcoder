# => 一括座標圧縮は、indexable.crで実装
#
# 座標圧縮（1次元）計算量 O(N logN)
#
# ```
# cc = CoodinateCompressLiner(Int32).new([100, -10, 5, -10])
# cc.src # => [100, -10, 5, -10]
# cc.dst # => [2, 0, 1, 0]
# cc.ref # => [-10, 5, 100]
# ```
class CoodinateCompressLiner(T)
  getter ref : Array(T)
  getter idx : Hash(T,Int32)

  def initialize(src)
    @ref = src.sort.uniq
    @idx = Hash(T,Int32).new
    src.each do |v|
      i = ref.bsearch_index do |u|
        v <= u
      end.not_nil!
      idx[v] = i
    end
  end

  delegate "[]", to: @idx
end

class CCL
  getter a : Array(Int64)
  getter ready : Bool

  def initialize
    @a = [] of Int64
    @ready = false
  end

  def <<(x : Int)
    raise "already commited" if ready
    a << x.to_i64
  end

  def add(xs : Array(Int))
    xs.each do |x|
      a << x.to_i64
    end
  end

  def [](x : Int)
    commit! unless ready
    a.bsearch_index do |v|
      x <= v
    end.not_nil!
  end

  def [](xs : Array(Int))
    xs.map do |x|
      self[x]
    end
  end

  private def commit!
    a.sort!.uniq!
    @ready = true
  end
end
