require "spec"
require "crystal/centroid_decomposition"

describe CentroidDecomposition do
  it "usage" do
    n = 7
    g = Graph.new(n, both: true, origin: 1)
    g.parse_plist([-1,1,1,3,3,5,5])
    cd = CentroidDecomposition.new(g)
    cd.build!
    cd.centroid_tree.to_plist.should eq [3, 1, -1, 3, 3, 5, 5]
  end
end
