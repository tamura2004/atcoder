# 座標圧縮（1次元）計算量 O(N logN)
#
# ```
# cc = CoodinateCompressLiner(Int32).new([100,-10,5,-10])
# cc.src # => [100, -10, 5, -10]
# cc.dst # => [2, 0, 1, 0]
# cc.ref # => [-10, 5, 100]
# ```
class CoodinateCompressLiner(T)
  getter src : Array(T)
  getter dst : Array(T)
  getter ref : Array(T)

  def initialize(@src)
    @ref = src.sort.uniq
    @dst = src.map do |i|
      ref.bsearch_index do |j|
        i <= j
      end || 0
    end
  end
end

alias CCL = CoodinateCompressLiner(Int64)
