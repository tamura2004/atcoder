require "spec"
require "crystal/graph"
require "crystal/graph/diameter"

describe Diameter do
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, 10
    g.add 2, 3, 20
    g.add 2, 4, 30
    g.add 1, 5, 50
    # +---+  50   +-----+
    # | 5 | ----- |  1  |
    # +---+       +-----+
    #               |
    #               | 10
    #               |
    # +---+  30   +-----+
    # | 4 | ----- |  2  |
    # +---+       +-----+
    #               |
    #               | 20
    #               |
    #             +-----+
    #             |  3  |
    #             +-----+
    Diameter.new(g).solve.should eq [3, 1, 0, 4]
  end
end
