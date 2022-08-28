require "spec"
require "crystal/graph/grid"
require "crystal/graph/depth"
require "crystal/graph/deg"

describe Grid do
  it "usage" do
    g = Grid.new(2,3,["..#","#.."])
    Depth.new(g).solve.should eq [0,1,-1,-1,2,3]
  end
  
  it "deg" do
    g = Grid.new(2,3,["..#","#.."])
    Deg.new(g).solve.should eq [1,2,0,0,2,1]
  end
end