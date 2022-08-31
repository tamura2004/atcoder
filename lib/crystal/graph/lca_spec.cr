require "spec"
require "crystal/graph"
require "crystal/graph/lca"

describe Lca do
  it "usage" do
    g = Graph.new(5)
    g.add 1, 3, 100
    g.add 1, 4, 100
    g.add 4, 2, 100
    g.add 4, 5, 100
    lca = Lca.new(g).solve(origin: 1)
    lca.call(5, 3).should eq 1
    lca.call(5, 2).should eq 4
  end
end
