require "spec"
require "crystal/pair_graph/graph.cr"
include PairGraph

describe Graph do
  it "usage" do
    g = Graph.new
    g.add 1, 2, 3, 4
    g.add 1, 2, 1, 4
    g.add 1, 3, 1, 4
    g.add 3, 5, 1, 3

    ShortestDepth.new(g).solve({1, 2})[{3, 5}].should eq 3
  end
end
