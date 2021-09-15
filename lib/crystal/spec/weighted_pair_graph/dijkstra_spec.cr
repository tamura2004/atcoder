require "spec"
require "crystal/weighted_pair_graph/dijkstra.cr"
include WeightedPairGraph

describe WeightedPairGraph::Dijkstra do
  it "usage" do
    g = Graph.new
    g.add 0, 0, 10, 20, 100
    g.add 0, 0, 1, 2, 10
    g.add 1, 2, 3, 4, 10
    g.add 3, 4, 10, 20, 10
    Dijkstra.new(g).solve({0, 0})[{10, 20}].should eq 30
  end
end
