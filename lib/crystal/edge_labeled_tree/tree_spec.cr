require "spec"
require "crystal/edge_labeled_tree/tree"
include EdgeLabeledTree

describe EdgeLabeledTree::Tree do
  it "usage" do
    g = Tree.new(4)
    g.add 4, 2, 0
    g.add 1, 2, 1
    g.add 1, 3, 2
    g.debug
  end
end
