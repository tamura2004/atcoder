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

  it "upto root" do
    g = Graph.new([3,9,10,8,8,9,10,3,-1,4,3,9])
    pa = Parent.new(g, 8)
    pa.up(0, 1).should eq 3
    pa.up(0, 2).should eq 8
    pa.up(0, 3).should eq -1
    pa.up(5, 1).should eq 9
    pa.up(5, 2).should eq 4
    pa.up(5, 3).should eq 8
    pa.up(5, 4).should eq -1
    pa.up(11, 1).should eq 9
    pa.up(11, 2).should eq 4
    pa.up(11, 3).should eq 8
    pa.up(11, 4).should eq -1
  end

  it "bug 4bit?" do
    g = Graph.new([13,1,2,3,4,5,3,7,8,3,10,11,-1], origin: 1)
    pa = Parent.new(g, 12)
    pp! pa.up(11,5)
    pp! pa.up(11,6)
    pp! pa.up(11,7)
  end
end
