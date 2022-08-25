require "crystal/graph/i_graph"
require "crystal/graph/printable"

class Graph
  include IGraph
  include Printable

  getter n : Int32
  getter g : Array(Array(Int32))

  def initialize(n)
    @n = n.to_i
    @g = Array.new(@n) { [] of Int32 }
  end

  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
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
end
