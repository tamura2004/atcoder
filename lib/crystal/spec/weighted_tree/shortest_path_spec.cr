require "spec"
require "crystal/weighted_tree/shortest_path"
include WeightedTree

describe WeightedTree::ShortestPath do
  it "usage" do
    g = Tree.new(5)
    g.add 1, 2, 100
    g.add 2, 3, 100
    g.add 3, 4, 100
    g.add 3, 5, 100
    path = ShortestPath.new(g)
    path.solve(3, 4).should eq [3, 2, 4]
  end
end
