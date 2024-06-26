require "spec"
require "crystal/bit_graph/chromatic_number"

include BitGraph

describe ChromaticNumber do
  it "彩色数1" do
    g = Graph.new(4)
    ChromaticNumber.new(g).solve.should eq 1
  end

  it "彩色数2" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
    ChromaticNumber.new(g).solve.should eq 2
  end

  it "彩色数3" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 1
    ChromaticNumber.new(g).solve.should eq 3
  end

  it "彩色数5" do
    g = Graph.new(5)
    g.add 1, 2
    g.add 1, 3
    g.add 1, 4
    g.add 1, 5
    g.add 2, 3
    g.add 2, 4
    g.add 2, 5
    g.add 3, 4
    g.add 3, 5
    g.add 4, 5
    ChromaticNumber.new(g).solve.should eq 5
  end
end
