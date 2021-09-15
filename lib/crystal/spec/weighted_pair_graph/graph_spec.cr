require "spec"
require "crystal/weighted_pair_graph/graph.cr"
include WeightedPairGraph

describe WeightedPairGraph::Graph do
  it "usage" do
    g = Graph.new
    g.add 1,2,3,4,100
    g.add 3,4,5,6,200
    g.g.keys.size.should eq 3
  end
end
