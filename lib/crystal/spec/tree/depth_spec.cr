require "spec"
require "crystal/tree/depth"

describe Depth do
  it "usage" do
    g = Tree.new(5)
    g.add 1, 2
    g.add 1, 3
    g.add 2, 4
    g.add 2, 5
    Depth.new(g).solve.should eq [0, 1, 1, 2, 2]
  end
end
