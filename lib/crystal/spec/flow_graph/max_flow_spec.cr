require "spec"
require "crystal/flow_graph/max_flow"
include FlowGraph

describe MaxFlow do
  it "usage" do
    g = Graph.new(8)
    g.add 0, 1, 1, origin: 0
    g.add 0, 2, 1, origin: 0
    g.add 0, 3, 1, origin: 0
    g.add 1, 4, 1, origin: 0
    g.add 2, 4, 1, origin: 0
    g.add 3, 4, 1, origin: 0
    g.add 1, 5, 1, origin: 0
    g.add 1, 6, 1, origin: 0
    g.add 4, 7, 1, origin: 0
    g.add 6, 7, 1, origin: 0
    g.add 6, 7, 1, origin: 0
    MaxFlow.new(g).solve(0, 7).should eq 2
  end
  it "usage weighted" do
    g = Graph.new(5)
    g.add 0, 1, 10_i64, origin: 0
    g.add 0, 2, 2_i64, origin: 0
    g.add 1, 2, 6_i64, origin: 0
    g.add 1, 3, 6_i64, origin: 0
    g.add 3, 2, 3_i64, origin: 0
    g.add 2, 4, 5_i64, origin: 0
    g.add 3, 4, 8_i64, origin: 0
    MaxFlow.new(g).solve(0, 4).should eq 11
  end
end
