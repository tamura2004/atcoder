# 重み付きユニオンファインド木
#
# ```
# a = [{1,1},{1,2},{2,2},{3,3}]
# => 1を含む部分グラフの頂点2
# uf = UnionFindTree.new(4)
# a.each do |i,j|
#   uf.unite(i,j)
# end
# uf.size(1) # => 2
#
# ```
class UnionFindTree
  getter n : Int32
  getter a : Array(Int32)
  getter w : Array(Int64)

  def initialize(n)
    @n = n.to_i

    # マイナスなら要素数、ゼロ以上なら親のインデックス
    @a = Array.new(n, -1)

    # 親ノードとの値の差分
    @w = Array.new(n, 0_i64)
  end

  def find(i)
    # マイナス=要素数を持つなら根なので自身を返す
    # そうでなければ経路圧縮
    # 先にfindを呼ぶことで累積和を実現
    a[i] < 0 ? i : (r = find(a[i]); w[i] += w[a[i]]; a[i] = r)
  end

  def same?(i, j)
    find(i) == find(j)
  end

  def size(i)
    -a[find(i)]
  end

  def weight(i)
    find(i)
    w[i]
  end

  def diff(i, j)
    weight(j) - weight(i)
  end

  def unite(i, j, wt = 0_i64)
    wt = wt.to_i64
    wt += weight(i)
    wt -= weight(j)

    i = find(i)
    j = find(j)
    return if i == j

    if a[i] > a[j]
      i, j = j, i
      wt = -wt
    end

    a[i] += a[j]
    a[j] = i
    w[j] = wt
  end

  def gsize
    n.times.map { |i| find(i) }.uniq.size
  end
end
