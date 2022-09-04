require "spec"
require "crystal/graph"
require "crystal/graph/depth"

describe Depth do
  it "usage" do
    g = Graph.new(6)
    g.add 0, 1, origin: 0
    g.add 1, 2, origin: 0
    g.add 4, 1, origin: 0
    g.add 3, 4, origin: 0
    g.add 4, 5, origin: 0
    Depth.new(g).solve(4).should eq [2, 1, 2, 1, 0, 1]
  end
end
