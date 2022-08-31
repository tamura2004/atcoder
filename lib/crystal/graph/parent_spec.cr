require "spec"
require "crystal/graph"
require "crystal/graph/parent"

describe Parent do
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2
    g.add 1, 3
    g.add 2, 4
    g.add 2, 5
    # +---+     +---+
    # | 3 | --- | 1 |
    # +---+     +---+
    #             |
    #             |
    #             |
    # +---+     +---+
    # | 5 | --- | 2 |
    # +---+     +---+
    #             |
    #             |
    #             |
    #           +---+
    #           | 4 |
    #           +---+
    Parent.new(g).solve.should eq [-1, 0, 0, 1, 1]
  end
end
