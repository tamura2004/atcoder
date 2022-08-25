require "crystal/graph/i_graph"

class PairGraph
  alias V = Tuple(Int32,Int32)

  include IGraph

  getter n : Int32
  getter g : Array(Array(Int32))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)

  def initialize
    @n = 0
    @g = [] of Array(Int32)
    @ix = Hash(V, Int32).new
    @vs = [] of V
  end

  def add(y, x, ny, nx, both = true)
    v = add_vertex(y, x)
    nv = add_vertex(ny, nx)
    g[v] << nv
    g[nv] << v if both
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

  private def add_vertex(y : Int32, x : Int32)
    v = {y, x}

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
