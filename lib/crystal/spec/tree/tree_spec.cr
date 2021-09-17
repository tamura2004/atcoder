require "spec"
require "crystal/tree"

describe Tree do
  it "usage" do
    g = Tree.make(10)
    g.n.should eq 10
  end
end
