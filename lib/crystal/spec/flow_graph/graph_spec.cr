require "spec"
require "crystal/flow_graph/graph.cr"
include FlowGraph

describe FlowGraph::Graph do
  it "usage" do
    g = Graph(Int32).new(4)
    g.add 0, 1, 10
    g.add 0, 2, 20
    g.add 1, 2, Int32::MAX
    g.add 1, 3, 7
    g.add 2, 3, 5
    g.debug
  end
end
