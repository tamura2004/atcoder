require "spec"
require "crystal/tree/subtree_size"

describe SubtreeSize do
  it "usage" do
    g = Tree.new(6)
    g.add 1, 2
    g.add 1, 3
    g.add 2, 4
    g.add 2, 5
    g.add 3, 6
    SubtreeSize.new(g).solve.should eq [6, 3, 2, 1, 1, 1]
  end
end
