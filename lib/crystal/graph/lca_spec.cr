require "spec"
require "crystal/graph"
require "crystal/graph/lca"

describe Lca do
  it "usage" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 3, 2
    g.add 5, 2
    g.add 4, 5
    g.add 6, 5

    lca = Lca.new(g, 4)
    lca.solve(2, 5).should eq 4
    lca.solve(2, 0).should eq 1
    lca.solve(2, 1).should eq 1
    lca.solve(2, 5).should eq 4
    lca.solve(0, 4).should eq 4
  end
end
