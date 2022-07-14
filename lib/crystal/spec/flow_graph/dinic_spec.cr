require "spec"
require "crystal/flow_graph/dinic"

describe FlowGraph::Dinic do
  it "usage" do
    # 蟻本p188の例
    g = Graph.new(5)
    g.add 0, 1, 10
    g.add 0, 2, 2
    g.add 1, 2, 6
    g.add 1, 3, 6
    g.add 3, 2, 3
    g.add 3, 4, 8
    g.add 2, 4, 5
    Dinic.new(g).solve.should eq 11
  end

  it "not overflow" do
    g = Graph.new(2)
    g.add 0,1,Int64::MAX - 1
    g.add 0,1,Int64::MAX - 1
    g.add 0,1,Int64::MAX
    g.add 0,1,Int64::MAX
    Dinic.new(g).solve.should eq Int64::MAX
  end
end
