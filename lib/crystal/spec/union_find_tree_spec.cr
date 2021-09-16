require "spec"
require "crystal/union_find_tree"

describe UnionFindTree do
  it "usage" do
    uf = UnionFindTree.new(3)
    uf.unite 0, 2
    uf.same?(1, 0).should eq false
    uf.same?(2, 0).should eq true
  end

  it "weight" do
    uf = UnionFindTree.new(4)
    uf.unite 0, 1, 5
    uf.unite 1, 2, 3
    uf.unite 3, 2, 6
    uf.diff(0, 3).should eq 2
  end

  it "find" do
    uf = UnionFindTree.new(4)
    uf.unite 0, 2
    uf.unite 1, 3

    uf.find(2).should eq 0
    uf.find(3).should eq 1
  end
end
