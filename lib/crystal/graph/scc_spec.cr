require "spec"
require "crystal/graph"
require "crystal/graph/scc.cr"

describe SCC do
  it "usage" do
    g = Graph.new(6)
    g.add 1,2,both: false
    g.add 2,3,both: false
    g.add 3,1,both: false
    g.add 1,4,both: false
    g.add 4,5,both: false
    g.add 5,6,both: false
    g.add 6,4,both: false

    SCC.new(g).solve.should eq [[0,1,2],[3,4,5]]
  end
end
