require "spec"
require "crystal//union_find"

describe UnionFind do
  it "usage" do
    uf = UnionFind.new(4)
    uf.unite(0, 1, 10)
    uf.unite(1, 2, 20)

    uf.size.should eq 2
    uf.same?(0, 2).should eq true
    uf.same?(0, 3).should eq false
    uf.diff(0, 2).should eq 30
    uf.diff(2, 0).should eq -30
    uf.vertex_size(0).should eq 3
    uf.edge_size(0).should eq 2
  end
  
  it "connected group" do
    uf = UnionFind.new(4)
    uf.unite(0, 1, 10)
    uf.unite(1, 2, 20)

    uf.group_parents.should eq [2, 3]
    uf.group_children.should eq [[0, 1, 2], [3]]
    uf.group_vertex_size.should eq [3, 1]
    uf.group_edge_size.should eq [2, 0]
  end
end
