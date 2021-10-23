require "spec"
require "crystal/weighted_tree/diameter"
include WeightedTree

describe WeightedTree::Diameter do
  it "usage" do
    g = Tree.new(5)
    g.add 1, 2, 10
    g.add 2, 3, 20
    g.add 2, 4, 30
    g.add 1, 5, 50
    Diameter.new(g).solve.should eq [3,1,0,4]

  end
end
