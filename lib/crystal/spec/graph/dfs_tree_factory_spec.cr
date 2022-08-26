require "spec"
require "crystal/graph/pair_graph"
require "crystal/graph/dfs_tree_factory"

describe DfsTreeFactory do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 1, 3
    g.add 2, 3
    DfsTreeFactory.new(g).solve(0).g.should eq [[1], [2], [] of Int32]
  end

  it "pair graph" do
    g = PairGraph.new
    g.add ({1, 10}), ({2, 20})
    g.add ({1, 10}), ({3, 30})
    g.add ({2, 20}), ({3, 30})
    DfsTreeFactory.new(g).solve(0).g.should eq [[1], [2], [] of Int32]
  end
end
