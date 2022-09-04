require "spec"
require "crystal/graph"
require "crystal/graph/diameter"

describe Diameter do
  it "weighted graph" do
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
    Diameter.new(g).solve.should eq ({4, 3})
  end

  it "usage" do
    g = Graph.new(5)
    g.add 2, 1
    g.add 2, 3
    g.add 3, 4
    g.add 2, 5
    Diameter.new(g).solve.should eq ({3,4})
  end

  it "debug" do
    g = Graph.new([5,6,7,10,9,9,-1,7,8,8], origin: 1)
    Diameter.new(g).solve.should eq ({3,1})
  end
end
