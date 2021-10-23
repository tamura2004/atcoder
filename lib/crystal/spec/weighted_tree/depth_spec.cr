require "spec"
require "crystal/weighted_tree/depth"
include WeightedTree

describe WeightedTree::Depth do
  it "usage" do
    g = Tree.new(5)
    g.add 1, 2, 10
    g.add 2, 3, 20
    g.add 2, 4, 30
    g.add 1, 5, 50
    Depth.new(g).solve.should eq [0,10,30,40,50]
  end
end
