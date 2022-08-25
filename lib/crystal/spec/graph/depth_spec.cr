require "spec"
require "crystal/graph"
require "crystal/graph/grid"
require "crystal/graph/weighted_graph"
require "crystal/graph/pair_graph"
require "crystal/graph/depth"

describe Depth do
  it "usage" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 1, 4
    g.add 4, 3
    Depth.new(g).solve.should eq [0, 1, 2, 1]
  end

  it "weighted graph" do
    g = WeightedGraph.new(4)
    g.add 1, 2, 3
    g.add 1, 4, 5
    g.add 4, 3, 6
    Depth.new(g).solve.should eq [0, 1, 2, 1]
  end

  it "grid" do
    g = Grid.new(2, 3, [".#.", "..."])
    Depth.new(g).solve.should eq [0, -1, 4, 1, 2, 3]
  end

  it "pair graph" do
    g = PairGraph.new
    g.add 1,10,2,20
    g.add 2,20,3,30
    Depth.new(g).solve.should eq [0,1,2]
  end
end
