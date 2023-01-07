require "spec"
require "crystal/weighted_flow_graph_with_bellmanford/min_cost_flow"
include WeightedFlowGraphWithBellmanford

describe WeightedFlowGraphWithBellmanford::MinCostFlow do
  it "usage" do
    g = Graph.new(3)
    g.add 0, 1, 10, -100
    g.add 1, 2, 5, -10
    MinCostFlow.new(g).solve(0, 2, 5).should eq ({5, -550})
  end

  it "negative cost" do
    g = Graph.new(4)
    g.add 0, 1, 1000, -2000
    g.add 0, 2, 2000, -1000
    g.add 1, 3, 1000, 0
    g.add 2, 3, 2000, 0
    MinCostFlow.new(g).solve(0, 3, 2000).should eq ({2_000, -3_000_000})
  end
end
