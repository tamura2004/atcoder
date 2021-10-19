require "spec"
require "crystal/weighted_tree/to_tree"

describe WeightedTree::ToTree do
  it "usage" do
    g = WeightedTree::Tree.new(3)
    g.add 1,2,10
    g.add 2,3,20
    ng, costs = WeightedTree::ToTree.new(g).solve
    ng.debug
    pp costs

  end
end
