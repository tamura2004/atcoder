require "spec"
require "crystal/weighted_tree/parent"
include WeightedTree

describe WeightedTree::Parent do
  it "usage" do
    g = Tree.new(5)
    g.add 1, 2, 10
    g.add 1, 3, 20
    g.add 2, 4, 30
    g.add 2, 5, 40
    Parent.new(g).solve.should eq [{-1, -1}, {0, 10}, {0, 20}, {1, 30}, {1, 40}]
  end
end
