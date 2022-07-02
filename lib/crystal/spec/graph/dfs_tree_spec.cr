require "spec"
require "crystal/graph/dfs_tree"

describe DFSTree do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 1, 3
    g.add 2, 3
    DFSTree.new(g).solve(0).g.should eq [[1], [2], [] of Int32]
  end
end
