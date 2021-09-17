require "spec"
require "crystal/graph/scc.cr"

describe SCC do
  it "usage" do
    g = Graph.new(4)
    g.add 4, 3, both: false
    g.add 3, 2, both: false
    g.add 2, 1, both: false
    g.add 1, 2, both: false
    cg, vs, ix = SCC.new(g).solve
    ix.should eq [2, 2, 1, 0]
  end
  
  it "component set" do
    ix = [0, 0, 1, 1]
    SCC::ComponentSet.new(ix).solve.should eq [Set{0, 1}, Set{2, 3}]
  end
  
  it "component graph" do
    g = Graph.new(4)
    g.add 4, 3, both: false
    g.add 3, 2, both: false
    g.add 2, 1, both: false
    g.add 1, 2, both: false
    ix = [0, 0, 1, 1]
    cg = SCC::ComponentGraph.new(g, ix).solve
    cg.n.should eq 2
    cg.g.should eq [[] of Int32, [0]]
  end
end
