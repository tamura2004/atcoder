require "spec"
require "crystal/weighted_flow_graph_with_bellmanford/graph"
include WeightedFlowGraphWithBellmanford

describe WeightedFlowGraphWithBellmanford::Graph do
  it "usage" do
    g = Graph.new(4)
    g.add 0, 1, 10,20
  end
end
