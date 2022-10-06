require "spec"
require "crystal/grid"

describe Grid do
  it "usage" do
    g = Grid.new(2,3,["a.#","#.z"])
    g.index('a').should eq C.zero
    g.index('z').should eq (1.y + 2.x)
    # g[0.y+1.x].should eq '.'
    # g.outside?(0.y+1.x).should eq false
    # g.outside?(0.y+10.x).should eq true
  end
end