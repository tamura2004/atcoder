require "crystal/graph/i_graph"
require "crystal/graph/i_weighted_graph"
require "crystal/graph/i_tree"
require "crystal/graph/printable"

class Graph
  include IGraph
  include IWeightedGraph
  include ITree
  include Printable

  getter n : Int32               # 頂点数
  getter m : Int32               # 辺数
  getter both : Bool             # 無向/有向
  getter g : Array(Array(Tuple(Int32,Int64))) # 隣接リスト

  def initialize(n, @both = true)
    @n = n.to_i
    @m = 0
    @g = Array.new(@n) { [] of Tuple(Int32,Int64) }
  end

  def read(origin = 1, both = true)
    v, nv = gets.to_s.split.map(&.to_i)
    add(v, nv, origin: origin, both: both)
  end

  def read_with_cost(origin = 1, both = true)
    v, nv, cost = gets.to_s.split.map(&.to_i64)
    add(v, nv, cost, origin: origin, both: both)
  end

  def add(v, nv, cost = 1_i64, origin = 1, both = true)
    @m += 1
    @both = both

    v = v.to_i - origin
    nv = nv.to_i - origin
    cost = cost.to_i64

    g[v] << {nv, cost}
    g[nv] << {v, cost} if both
  end

  def tree!
    raise "木ではありません n: #{n}, m: #{m}" if n - 1 != m
  end

  def each(&b : Int32 -> _)
    n.times do |v|
      b.call v
    end
  end

  def each(v : Int32, &b : Int32 -> _)
    g[v].each do |nv, _|
      b.call nv
    end
  end

  def each_with_cost(v : Int32, &b : (Int32, Int64) -> _)
    g[v].each do |nv, cost|
      b.call nv, cost
    end
  end
end
