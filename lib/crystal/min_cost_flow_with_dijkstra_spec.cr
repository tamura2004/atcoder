require "spec"
require "crystal/min_cost_flow_with_dijkstra"

describe MinCostFlow do
  it "usage" do
    g = Graph.new(4)
    g.add 0, 1, 2, 2
    g.add 0, 2, 1, 1
    g.add 1, 3, 1, 1
    g.add 2, 3, 1, 1
    MinCostFlow.new(g).solve(0,3,2).should eq 5
  end

  it "negative cost" do
    g = Graph.new(4)
    g.add 0, 1, 2, -2
    g.add 0, 2, 1, -1
    g.add 1, 3, 1, -1
    g.add 2, 3, 1, -1
    MinCostFlow.new(g).solve(0,3,2).should eq -6
  end
end
