require "spec"
require "../graph"

describe Graph do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 3, 1
    g.is_bipartite?.should eq [0,1,1]
  end
  
  it "usage 2" do
    g = Graph.new(3)
    g.add 1, 2
    g.is_bipartite?.should eq [0,1,0]
  end
end
