require "spec"
require "crystal/weighted_flow_graph_with_bellmanford/bellman_ford"
include WeightedFlowGraphWithBellmanford

describe WeightedFlowGraphWithBellmanford::BellmanFord do
  it "usage" do
    g = Graph.new(4)
    g.add 0, 1, 10, -10
    g.add 0, 2, 5, 5
    g.add 1, 3, 5, 5
    g.add 2, 3, 10, -10
  end
end
