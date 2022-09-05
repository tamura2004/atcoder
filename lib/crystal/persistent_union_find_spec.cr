require "spec"
require "crystal/persistent_union_find"

describe PersistentUnionFind do
  it "usage" do
    uf = PersistentUnionFind.new
    uf.same?(0,0).should eq true
    uf.same?(0,1).should eq false
    uf0 = uf.unite(0,1)
    uf1 = uf0.unite(0,2)
    uf.same?(0,1).should eq false
    uf0.same?(0,1).should eq true
    uf1.same?(0,1).should eq true
    uf5 = uf1.unite(3,4)
    uf6 = uf1.unite(2,3)
    uf5.same?(1,4).should eq false
    uf8 = uf5.unite(2,3)
    uf8.same?(1,4).should eq true
    uf10 = uf6.unite(3,4)
    uf10.same?(1,4).should eq true
  end
end
