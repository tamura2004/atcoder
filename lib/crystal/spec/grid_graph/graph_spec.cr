require "spec"
require "crystal/grid_graph/graph"
include GridGraph

describe GridGraph::Graph do
  it "usage" do
    g = Graph.new(4,3)
    g.to_ix(2, 1).should eq 7
    g.from_ix(7).should eq ({2,1})
  end
end
