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
  end

  it "connected component" do
    g = Graph.new([
      "0000",
      "1111",
      "1111",
      "1001",
    ])
    g.connect.should eq 2
  end

  it "connected component" do
    g = Graph.new([
      "0000",
      "1111",
      "1001",
      "1111",
    ])
    g.connect.should eq 3
  end
  
  it "next candidate" do
    g = Graph.new([
      "0000",
      "0110",
      "0000",
      "0000",
    ])
    g.next_candidate do |i|
      i.debug
    end
  end
end
