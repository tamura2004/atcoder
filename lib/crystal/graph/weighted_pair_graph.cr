require "crystal/graph/i_weighted_graph"

class WeightedPairGraph
  alias V = Tuple(Int32, Int32)
  alias E = Tuple(Int32, Int64)

  include IWeightedGraph

  getter n : Int32
  getter g : Array(Array(E))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)

  def initialize
    @n = 0
    @g = [] of Array(E)
    @ix = Hash(V, Int32).new
    @vs = [] of V
  end

  def add(y, x, ny, nx, cost, both = true)
    v = add_vertex(y, x)
    nv = add_vertex(ny, nx)
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

  private def add_vertex(y : Int32, x : Int32)
    v = {y, x}

    if i = ix[v]?
      return i
    end

    ret = ix[v] = vs.size
    vs << v
    g << [] of E
    @n += 1
    ret
  end
end
