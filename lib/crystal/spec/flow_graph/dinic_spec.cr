require "spec"
require "crystal/flow_graph/dinic"
include FlowGraph

describe FlowGraph::Dinic do
  it "usage" do
    # 蟻本p188の例
    g = Graph(Int64).new(4)
    g.add 0, 1, 10
    g.add 0, 2, 1
    g.add 1, 2, 8
    g.add 1, 3, 1
    g.add 2, 3, 10
  end

  it "not overflow" do
    g = Graph(Int64).new(2)
    g.add 0,1,Int64::MAX - 1
    g.add 0,1,Int64::MAX - 1
    g.add 0,1,Int64::MAX
    g.add 0,1,Int64::MAX
    Dinic(Int64).new(g).solve.should eq Int64::MAX
  end
end
