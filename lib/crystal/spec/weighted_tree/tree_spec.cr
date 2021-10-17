require "spec"
require "crystal/weighted_tree/tree"
include WeightedTree

describe WeightedTree::Tree do
  it "usage" do
    g = Tree.new(4)
    g.add 1,2,10
    g.add 1,3,20
    g.add 3,4,30
    g.debug
  end
end
