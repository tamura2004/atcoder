require "spec"
require "crystal/abstruct_graph/dijkstra"
include AbstructGraph

record V, v : Int32, rank : Int32
record E, v : V, nv : V, color : Int32
record S, cost : Int64, v : V do
  include Comparable(S)

  def <=>(b : self)
    cost <=> b.cost
  end
end

describe AbstructGraph::Dijkstra do
  it "usage" do

    a1 = V.new(0, 0)
    a2 = V.new(1, 0)
    a3 = V.new(0, 1)
    a4 = V.new(1, 1)

    g = Graph(V, E).new
    g.add a1, E.new(a1, a2, 1)
    g.add a1, E.new(a1, a3, 0)
    g.add a1, E.new(a2, a4, 0)
    g.add a1, E.new(a3, a4, 0)

    nex = ->(s : S, e : E) {
      cost = e.color == 0 ? 20 : 10
      S.new(s.cost + cost, e.nv)
    }
    init = S.new(0_i64, a1)
    Dijkstra(V, E, S).new(g, nex).solve(init)[a4].should eq 20
  end
end
