require "spec"
require "crystal/graph"
require "crystal/graph/h_l_decomposition"

describe HLDecomposition do
  it "usage" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)
    hld.enter.should eq [6, 7, 5, 0, 2, 1, 3, 4]
    hld.par.should eq [2, 2, 3, -1, 5, 3, 4, 5]
    hld.head.should eq [2, 1, 2, 3, 3, 3, 3, 7]
    hld.sub.should eq [1, 1, 3, 8, 2, 4, 1, 1]

    hld.lca(7,6).should eq 5
    hld.lca(0,4).should eq 3
    hld.lca(3,3).should eq 3
    hld.lca(2,7).should eq 3
  end
end
