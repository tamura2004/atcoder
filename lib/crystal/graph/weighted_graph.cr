require "crystal/graph/i_graph"
require "crystal/graph/i_weighted_graph"
require "crystal/graph/printable"

class WeightedGraph
  include IGraph
  include IWeightedGraph
  include Printable

  getter n : Int32
  getter g : Array(Array(Tuple(Int32, Int64)))

  def initialize(n)
    @n = n.to_i
    @g = Array.new(@n) { [] of Tuple(Int32, Int64) }
  end

  def add(v, nv, cost, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    cost = cost.to_i64

    g[v] << {nv, cost}
    g[nv] << {v, cost} if both
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
