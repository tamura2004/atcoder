require "spec"
require "crystal/graph/weighted_graph"
require "crystal/graph/weighted_pair_graph"
require "crystal/graph/dijkstra"

describe Dijkstra do
  it "usage" do
    g = WeightedGraph.new(3)
    g.add 1, 2, 3
    g.add 2, 3, 4
    Dijkstra.new(g).solve.should eq [0, 3, 7]
  end

  it "with weighted pair graph" do
    g = WeightedPairGraph.new
    g.add 1, 10, 2, 20, 3
    g.add 2, 20, 3, 30, 4
    Dijkstra.new(g).solve.should eq [0, 3, 7]
  end
end
