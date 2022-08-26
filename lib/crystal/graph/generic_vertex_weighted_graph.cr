require "crystal/graph/i_weighted_graph"

class GenericVertexWeightedGraph(V)
  alias E = Tuple(Int32, Int64)

  include IWeightedGraph

  getter n : Int32
  getter g : Array(Array(E))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)

  def initialize
    @n = 0
    @g = [] of Array(E)
    @ix = {} of V => Int32
    @vs = [] of V
  end

  def add(v : V, nv : V, cost, both = true)
    vi = add_vertex(v)
    nvi = add_vertex(nv)
    cost = cost.to_i64

    g[vi] << {nvi, cost}
    g[nvi] << {vi, cost} if both
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

  private def add_vertex(v : V)
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
