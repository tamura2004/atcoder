require "spec"
require "crystal/tree/lca"

describe Tree do
  it "usage" do
    g = Tree.new(5)
    g.add 1, 3
    g.add 1, 4
    g.add 4, 2
    g.add 4, 5
    lca = Lca.new(g).solve(origin: 1)
    lca.call(5, 3).should eq 1
    lca.call(5, 2).should eq 4
  end
end
