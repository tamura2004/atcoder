require "spec"
require "crystal/bit_grid_graph/graph"
include BitGridGraph

describe BitGridGraph::Graph do
  it "usage" do
    g = Graph.new(4,4)
    g.set 15+15*16*16*16
    g[0,1] = 0
    g[0,2] = 0
  end

  it "init from string" do
    g = Graph.new([
      "1011",
      "0101",
      "0010",
      "0001"
    ])

    g.to_string_array.should eq [
      "1011",
      "0101",
      "0010",
      "0001"
    ]
    g.to_s.should eq "1011010100100001"
  end
end
