require "spec"
require "crystal/grid"

describe Grid do
  it "usage" do
    g = Grid.new(["a.#", "#.z"])
    # a.#
    # #.z

    g[{0, 0}].should eq 'a'
    g.each({1, 1}).to_a.should eq [{0, 1}, {1, 2}, {1, 0}]
    g.each_with_index({1, 1}).to_a.should eq [{'.', 0, 1}, {'z', 1, 2}, {'#', 1, 0}]
    # g[0.y+1.x].should eq '.'
    # g.outside?(0.y+1.x).should eq false
    # g.outside?(0.y+10.x).should eq true
  end
end
