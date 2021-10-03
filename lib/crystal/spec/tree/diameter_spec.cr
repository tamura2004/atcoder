require "spec"
require "crystal/tree/diameter"

describe Diameter do
  it "usage" do
    g = Tree.new(6)
    g.add 1, 2
    g.add 3, 2
    g.add 2, 4
    g.add 4, 5
    g.add 4, 6

    Diameter.new(g).solve.should eq [0, 1, 3, 4]
  end
end
