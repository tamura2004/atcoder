require "spec"
require "crystal/graph"
require "crystal/graph/base_graph"
require "crystal/graph/dijkstra"

describe Dijkstra do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2, 3
    g.add 2, 3, 4
    Dijkstra.new(g).solve.should eq [0, 3, 7]
  end

  it "with weighted pair graph" do
    g = BaseGraph(Tuple(Int32, Int32)).new
    g.add ({1, 10}), ({2, 20}), 3_i64
    g.add ({2, 20}), ({3, 30}), 4_i64
    Dijkstra.new(g).solve.should eq [0, 3, 7]
  end
end
