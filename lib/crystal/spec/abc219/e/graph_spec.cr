require "spec"
require "crystal/abc219/e/graph"
include Abc219::E

describe Abc219::E::Graph do
  it "regal" do
    g = Graph.new([
      "1111",
      "0111",
      "1110",
      "0000",
    ])
    g.debug
    g.connected.should eq 2
  end

  it "regal all" do
    g = Graph.new([
      "1111",
      "1111",
      "1111",
      "1111",
    ])
    g.debug
    g.connected.should eq 2
  end

  it "disconnect" do
    g = Graph.new([
      "1111",
      "1100",
      "0001",
      "1111",
    ])
    g.debug
    g.connected.should eq 3
  end

  it "hole" do
    g = Graph.new([
      "1111",
      "1101",
      "1001",
      "1111",
    ])
    g.debug
    g.connected.should eq 3
  end

  it "from int" do
    v = (15<<12) + (13<<8) + (9<<4) + 1
    g = Graph.new(v)
    g.debug
    g.to_i.should eq v
  end
end
