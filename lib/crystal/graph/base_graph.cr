require "crystal/graph/i_graph"
require "crystal/graph/i_tree"
require "crystal/graph/printable"

# 汎用グラフ
class BaseGraph(V)
  include IGraph
  include ITree
  include Printable

  getter n : Int32
  getter m : Int32
  getter both : Bool
  getter origin : Int32

  getter g : Array(Array(Tuple(Int32,Int64,Int32)))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)
  getter es : Array(Tuple(Int32,Int32,Int64,Int32))

  # 空のグラフを初期化
  def initialize(@n = 0, @origin = 1, @both = true)
    @m = 0
    @g = Array.new(n) { [] of Tuple(Int32, Int64, Int32) }
    @ix = {} of V => Int32
    @vs = [] of V
    @es = [] of Tuple(Int32,Int32,Int64,Int32)
  end
  
  # 親の頂点リストで木を初期化
  def initialize(pa : Array(Int32), @origin = 0, @both = true)
    @n = pa.size
    @m = 0
    @g = Array.new(n) { [] of Tuple(Int32, Int64, Int32) }
    @ix = {} of V => Int32
    @vs = [] of V
    @es = [] of Tuple(Int32,Int32,Int64,Int32)

    pa.each_with_index do |pv, v|
      next if pv == -1
      add v + origin, pv
    end
  end

  # 辺の追加
  def add(v : V, nv : V, cost = 1_i64, origin = nil, both = nil)
    @origin = origin unless origin.nil?
    @both = both unless both.nil?

    i = add_vertex(v)
    j = add_vertex(nv)
    cost = cost.to_i64

    es << {i, j, cost, g[i].size}
    g[i] << {j, cost, m}
    
    if @both
      g[j] << {i, cost, m}
    end
    
    @m += 1
  end

  def each
    n.times do |i|
      yield i
    end
  end

  def each(i : Int32)
    g[i].each do |j, _, _|
      yield j
    end
  end

  def each_with_cost(i : Int32)
    g[i].each do |j, cost, _|
      yield j, cost
    end
  end

  def each_with_index(i : Int32)
    g[i].each do |j, _, k|
      yield j, k
    end
  end

  def each_cost_with_index(i : Int32)
    g[i].each do |j, cost, k|
      yield j, cost, k
    end
  end

  def weighted?
    g.flatten.any?(&.[1].> 1)
  end

  private def add_vertex(i : Int32)
    i - origin
  end

  private def add_vertex(v : V)
    if i = ix[v]?
      return i
    end

    ret = ix[v] = vs.size
    vs << v
    g << [] of Tuple(Int32, Int64, Int32)
    @n += 1
    ret
  end
end
