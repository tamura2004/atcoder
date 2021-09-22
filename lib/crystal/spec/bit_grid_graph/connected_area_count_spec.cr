require "spec"
require "crystal/bit_grid_graph/connected_area_count"
include BitGridGraph

describe BitGridGraph::ConnectedAreaCount do
    it "connected component" do
      g = Graph.new([
        "0000",
        "1111",
        "1111",
        "1001",
      ])
      ConnectedAreaCount.new(g).solve.should eq 2
    end

    it "connected component" do
      g = Graph.new([
        "0000",
        "1111",
        "1001",
        "1111",
      ])
      ConnectedAreaCount.new(g).solve.should eq 3
    end
  end
