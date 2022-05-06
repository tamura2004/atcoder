require "spec"
require "crystal/weighted_flow_graph/bellman_ford"
include WeightedFlowGraph

describe BellmanFord do
  it "負のコストを持つグラフの最短経路" do
    g = Graph.new(3)
    g.add 1, 2, 100, 20, origin: 1
    g.add 2, 3, 100, -30, origin: 1
    g.add 1, 3, 100, 10, origin: 1
    dist, path = BellmanFord.new(g).solve
    dist.should eq [0, 20, -10]
    # prevv.should eq [-1, 0, 1]
    # preve.should eq [-1, 0, 1]
  end

  it "負閉路あり" do
    g = Graph.new(3)
    g.add 0, 1, 100, -10
    g.add 1, 0, 100, -10
    g.add 0, 2, 100, 10
    expect_raises(Exception, "infinit negative cost loop") do
      dist, path = BellmanFord.new(g).solve
    end
  end
end
