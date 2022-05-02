require "spec"
require "crystal/graph/dfs_path_decomposition"

describe DfsPathDecomposition do
  it "usage" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 1, 4
    g.add 2, 4
    g.add 2, 3
    g.add 4, 3
    pathes = DfsPathDecomposition.new(g).solve
    pathes.should eq [[0, 1, 3, 2]]
  end
end
