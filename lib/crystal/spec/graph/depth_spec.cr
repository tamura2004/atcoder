require "spec"
require "crystal/graph/depth"

describe Depth do
  it "usage" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 1, 4
    g.add 4, 3
    Depth.new(g).solve.should eq [0, 1, 2, 1]
  end
end
