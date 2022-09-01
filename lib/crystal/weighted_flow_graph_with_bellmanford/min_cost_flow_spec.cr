require "spec"
require "crystal/weighted_flow_graph_with_bellmanford/min_cost_flow"
include WeightedFlowGraphWithBellmanford

describe WeightedFlowGraphWithBellmanford::MinCostFlow do
  it "usage" do
    g = Graph.new(3)
    g.add 0, 1, 10, -100
    g.add 1, 2, 5, -10
    MinCostFlow.new(g).solve(0,2,5).should eq ({5,-550})
  end
end
