require "spec"
require "crystal/graph"
require "crystal/graph/low_link"

describe LowLink do
  it "usage" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 3, 2
    g.add 1, 3
    g.add 1, 4
    g.add 4, 5
    g.add 6, 5
    g.add 4, 6
    bridge, articulation, ord, low = LowLink.new(g).solve
    bridge.should eq [{0, 3}]
    articulation.should eq [3, 0]
    ord.should eq [0, 1, 2, 3, 4, 5]
    low.should eq [0, 0, 0, 3, 3, 3]
    puts g
  end
end
