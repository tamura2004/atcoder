require "crystal/graph/i_graph"
require "crystal/graph/i_weighted_graph"

module IWeightedEdge
  abstract def cost : Int64
end

class GenericVertexEdgeGraph(V)
  alias E = IWeightedEdge

  include IGraph
  include IWeightedGraph

  getter n : Int32
  getter g : Array(Array(Tuple(Int32, Int32)))
  getter m : Int32
  getter both : Bool
  getter ix : Hash(V, Int32)
  getter eix : Hash(E, Int32)
  getter vs : Array(V)
  getter es : Array(E)

  def initialize
    @n = 0
    @m = 0
    @both = true
    @g = [] of Array(Tuple(Int32, Int32))
    @ix = {} of V => Int32
    @eix = {} of E => Int32
    @vs = [] of V
    @es = [] of E
  end

  def add(v : V, nv : V, e : E, both = true)
    vi = add_vertex(v)
    nvi = add_vertex(nv)
    ei = add_edge(e)

    g[vi] << {nvi, ei}
    g[nvi] << {vi, ei} if both
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
    g[v].each do |nv, ei|
      b.call nv, es[ei].cost
    end
  end

  private def add_vertex(v : V) : Int32
    if i = ix[v]?
      return i
    end

    @n += 1
    ret = ix[v] = vs.size
    vs << v
    g << [] of Tuple(Int32, Int32)
    ret
  end

  private def add_edge(e : E) : Int32
    if i = eix[e]?
      return i
    end

    @m += 1
    ret = eix[e] = es.size
    es << e
    ret
  end
end
