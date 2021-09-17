require "spec"
require "crystal/weighted_flow_graph/min_cost_flow"
include WeightedFlowGraph

describe MinCostFlow do
  it "最小費用流を求める" do
    g = Graph.new(5)
    g.add 0, 1, 10, 2, origin: 0
    g.add 0, 2, 2, 4, origin: 0
    g.add 1, 2, 6, 6, origin: 0
    g.add 1, 3, 6, 2, origin: 0
    g.add 3, 2, 3, 3, origin: 0
    g.add 2, 4, 5, 2, origin: 0
    g.add 3, 4, 8, 6, origin: 0
    MinCostFlow.new(g).solve(0, 4, 9).should eq 80
  end
end
