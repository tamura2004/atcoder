require "spec"
require "crystal/graph"
require "crystal/graph/in_order_tree"

describe InOrderTree do
  it "usage" do
    g = Graph.new(4)
    g.add 4, 3, both: false
    g.add 4, 1, both: false
    g.add 1, 2, both: false
    gg, ord, vid, pa = InOrderTree.new(g).solve(4 - 1)
    ord.should eq [3, 2, 0, 1]
    vid.should eq [2, 3, 1, 0]
    pa.should eq [-1, 0, 0, 2]
  end
end
