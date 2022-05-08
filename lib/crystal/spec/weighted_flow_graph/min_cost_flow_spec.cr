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
    MinCostFlow.new(g).solve(0, 4, 9).should eq ({9, 80})
  end

  it "複数回" do
    g = Graph.new(2)
    g.add 0, 1, 1, 1
    g.add 0, 1, 1, 2
    g.add 0, 1, 1, 3
    mcf = MinCostFlow.new(g)
    mcf.solve(0, 1, 1).should eq ({1, 1})
    mcf.solve(0, 1, 1).should eq ({1, 2})
    mcf.solve(0, 1, 1).should eq ({1, 3})
  end

  # 流量とコストの折れ線グラフ
  it "slope" do
    g = Graph.new(2)
    g.add 0, 1, 1, 1
    g.add 0, 1, 2, 2
    g.add 0, 1, 1, 3
    mcf = MinCostFlow.new(g)
    mcf.slope(0, 1, 4).should eq [
      {0, 0},
      {1, 1},
      {3, 5},
      {4, 8},
    ]

    # 残余グラフ
    # v, nv, cap, flow, cost
    g.edges.should eq [
      {0, 1, 1, 1, 1},
      {0, 1, 2, 2, 2},
      {0, 1, 1, 1, 3},
    ]
  end

  it "overflow?" do
    g = Graph.new(3)
    g.add 0,1,1,1000000000
    g.add 1,2,1,1000000000
    MinCostFlow.new(g).solve(0,2,1).should eq ({1,2000000000})
  end

  # it "negative cost" do
  #   g = Graph.new(4)
  #   g.add 0, 1, 1000, -2000
  #   g.add 0, 2, 2000, -1000
  #   g.add 1, 3, 1000, 0
  #   g.add 2, 3, 2000, 0
  #   MinCostFlow.new(g).solve(0,3,2000).should eq ({2_000, -3_000_000})
  # end
end
