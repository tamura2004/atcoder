require "spec"
require "crystal/graph"
require "crystal/graph/bipartite_matching"

describe BipartiteMatching do
  it "usage" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 4, 5
    g.add 4, 6
    BipartiteMatching.new(g).solve.should eq ({2, [1, 0, -1, 4, 3, -1]})
  end
end
