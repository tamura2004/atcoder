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

alias CCL = CoodinateCompressLiner(Int64)
