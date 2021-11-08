require "spec"
require "crystal/graph/connected_decomposition"

describe ConnectedDecomposition do
  it "usage" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 1, 3
    g.add 4, 5

    CD.new(g).solve.should eq ({[3, 2, 1], [3, 1, 0]})
  end
end
