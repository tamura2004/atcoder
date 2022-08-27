require "spec"
require "crystal/graph/grid"
require "crystal/graph/depth"

describe Grid do
  it "usage" do
    g = Grid.new(2,3,["..#","#.."])
    Depth.new(g).solve.should eq [0,1,-1,-1,2,3]
  end
end