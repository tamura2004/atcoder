require "spec"
require "crystal/weighted_graph/graph.cr"
include WeightedGraph

describe WeightedGraph::Graph do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2, 100
    g.add 2, 3, 200
    g.add 3, 1, 300
  end
end
