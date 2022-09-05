require "spec"
require "crystal/graph"
require "crystal/graph/lca"

describe Lca do
  it "usage" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 3, 2
    g.add 5, 2
    g.add 4, 5
    g.add 6, 5

    lca = Lca.new(g, 4)
    lca.solve(2, 5).should eq 4
    lca.solve(2, 0).should eq 1
    lca.solve(2, 1).should eq 1
    lca.solve(2, 5).should eq 4
    lca.solve(0, 4).should eq 4
  end

  it "usage 2" do
    #           +---+
    #           | 7 |
    #           +---+
    #             |
    #             |
    #             |
    # +---+     +---+     +---+
    # | 1 | --- | 0 | --- | 6 |
    # +---+     +---+     +---+
    #             |
    #             |
    #             |
    #           +---+
    #           | 2 |
    #           +---+
    #             |
    #             |
    #             |
    # +---+     +---+
    # | 5 | --- | 3 |
    # +---+     +---+
    #             |
    #             |
    #             |
    #           +---+
    #           | 4 |
    #           +---+
    g = Graph.new([2, [0, 6, 7, 1], [3, 4, 5]], origin: 0)
    lca = Lca.new(g, 7)

    [
      {1, 2, 0},
      {2, 6, 0},
      {3, 5, 3},
      {3, 4, 3},
      {7, 4, 7},
    ].each do |v, nv, want|
      lca.solve(v, nv).should eq want
    end
  end
end
