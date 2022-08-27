require "crystal/graph/i_graph"
require "crystal/graph/i_weighted_graph"
require "crystal/graph/i_tree"
require "crystal/graph/printable"

# 任意オブジェクトを頂点に持つグラフ
class GenericVertexGraph(V)
  include IGraph
  include IWeightedGraph
  include ITree
  include Printable

  getter n : Int32                             # 頂点数
  getter m : Int32                             # 辺数
  getter both : Bool                           # 双方向
  getter g : Array(Array(Tuple(Int32, Int64))) # 隣接リスト
  getter vs : Array(V)                         # 頂点の配列
  getter ix : Hash(V, Int32)                   # 頂点から配列のインデックスへ

  def initialize
    @n = 0
    @m = 0
    @both = true
    @g = [] of Array(Tuple(Int32, Int64))
    @ix = Hash(V, Int32).new
    @vs = [] of V
  end

  def add(v : V, nv : V, cost = 1_i64, both = true)
    @both = both
    @m += 1
    cost = cost.to_i64
    i = add_vertex(v)
    j = add_vertex(nv)
    g[i] << {j, cost}
    g[j] << {i, cost} if both
  end

  def each(&b : Int32 -> _)
    n.times do |i|
      b.call i
    end
  end

  def each(i : Int32, &b : Int32 -> _)
    g[i].each do |j, _|
      b.call j
    end
  end

  def each_with_cost(i : Int32, &b : (Int32, Int64) -> _)
    g[i].each do |j, cost|
      b.call j, cost
    end
  end

  private def add_vertex(v : V) : Int32
    if i = ix[v]?
      return i
    end

    ret = ix[v] = vs.size
    vs << v
    g << [] of Tuple(Int32,Int64)
    @n += 1
    ret
  end
end
