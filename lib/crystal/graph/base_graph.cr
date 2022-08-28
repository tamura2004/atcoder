require "crystal/graph/i_graph"
require "crystal/graph/i_tree"
require "crystal/graph/printable"

class BaseGraph(V, E)
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
  getter es : Array(E)

  def initialize(@n = 0, @origin = 1, @both = true)
    @m = 0
    @g = Array.new(n) { [] of Tuple(Int32,Int64,Int32) }
    @ix = {} of V => Int32
    @vs = [] of V
    @es = [] of E
  end

  def add(v : V, nv : V, e : E? = nil, origin = nil, both = nil)
    @origin = origin unless origin.nil?
    @both = both unless both.nil?
    
    i = add_vertex(v)
    j = add_vertex(nv)
    cost = e ? get_cost(e) : 1_i64
    
    g[i] << { j, cost, m }
    g[j] << { i, cost, m } if @both
    
    @m += 1
  end

  def each(&b : Int32 -> _)
    n.times do |i|
      b.call i
    end
  end

  def each(i : Int32, &b : Int32 -> _)
    g[i].each do |j, _, _|
      b.call j
    end
  end

  def each_with_cost(i : Int32, &b : (Int32, Int64) -> _)
    g[i].each do |j, cost, _|
      b.call j, cost
    end
  end

  private def get_cost(e : Int64) : Int64
    e
  end

  private def get_cost(e : E) : Int64
    if e.responds_to?(:cost)
      e.cost
    elsif e.responds_to?(:first)
      e.first
    else
      1_i64
    end
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
    g << [] of Tuple(Int32,Int64,Int32)
    @n += 1
    ret
  end
end
