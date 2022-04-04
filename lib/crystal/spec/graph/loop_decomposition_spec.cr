require "spec"
require "crystal/graph/loop_decomposition"

describe LoopDecomposition do
  it "usage" do
    g = Graph.new(5)
    g.add 4, 2, origin: 0, both: false
    g.add 2, 0, origin: 0, both: false
    g.add 0, 4, origin: 0, both: false
    g.add 3, 1, origin: 0, both: false
    g.add 1, 3, origin: 0, both: false
    ld = LoopDecomposition.new(g)
    ld.solve.should eq [[0,4,2],[1,3]]
  end
end
