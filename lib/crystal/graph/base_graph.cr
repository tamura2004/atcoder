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

  getter g : Array(Array(Tuple(Int32, Int64, Int32)))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)
  getter es : Array(E)

  def initialize(@n = 0, @origin = 1, @both = true)
    @m = 0
    @g = Array.new(n) { [] of Tuple(Int32, Int64, Int32) }
    @ix = {} of V => Int32
    @vs = [] of V
    @es = [] of E
  end

  def add(v : V, nv : V, e : E? = nil, origin = nil, both = nil)
    @origin = origin unless origin.nil?
    @both = both unless both.nil?

    i = add_vertex(v)
    j = add_vertex(nv)
    k, cost = add_edge(e)

    g[i] << {j, cost, k}
    g[j] << {i, cost, k} if @both
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

  def each_with_edge(i : Int32)
    g[i].each do |j, _, k|
      yield j, es[k]
    end
  end
  
  def each_with_index(i : Int32)
    g[i].each do |j, cost, k|
      yield j, cost, k
    end
  end

  def weighted?
    g.flatten.any?(&.[1].> 1)
  end

  private def add_edge(e : E?) : Tuple(Int32, Int64)
    ({@m, get_cost(e)}).tap do
      @es << e unless e.nil?
      @m += 1
    end
  end

  private def get_cost(e : E?) : Int64
    case e
    when Int64
      e
    when Nil
      1_i64
    when NamedTuple
      e[:cost]? || 1_i64
    else
      if e.responds_to?(:cost)
        e.cost
      elsif e.responds_to?(:first)
        e.first
      else
        1_i64
      end
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
    g << [] of Tuple(Int32, Int64, Int32)
    @n += 1
    ret
  end
end
