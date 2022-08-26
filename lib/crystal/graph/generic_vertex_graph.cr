require "crystal/graph/i_graph"
require "crystal/graph/printable"

class GenericVertexGraph(V)
  include IGraph
  include Printable

  getter n : Int32
  getter m : Int32
  getter both : Bool
  getter g : Array(Array(Int32))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)

  def initialize
    @n = 0
    @m = 0
    @both = true
    @g = [] of Array(Int32)
    @ix = Hash(V, Int32).new
    @vs = [] of V
  end

  def add(v : V, nv : V, both = true)
    @both = both
    @m += 1
    vi = add_vertex(v)
    nvi = add_vertex(nv)
    g[vi] << nvi
    g[nvi] << vi if both
  end

  def each(&b : Int32 -> _)
    n.times do |v|
      b.call v
    end
  end

  def each(v : Int32, &b : Int32 -> _)
    g[v].each do |nv|
      b.call nv
    end
  end

  private def add_vertex(v : V) : Int32
    if i = ix[v]?
      return i
    end

    ret = ix[v] = vs.size
    vs << v
    g << [] of Int32
    @n += 1
    ret
  end
end
