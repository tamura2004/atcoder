require "spec"
require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/segment_tree"

describe HLDecomposition do
  it "usage" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)

    hld.enter.should eq [6, 7, 5, 0, 2, 1, 3, 4]
    hld.par.should eq [2, 2, 3, -1, 5, 3, 4, 5]
    hld.head.should eq [2, 1, 2, 3, 3, 3, 3, 7]
    hld.sub.should eq [1, 1, 3, 8, 2, 4, 1, 1]
  end

  it "lca" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)

    hld.lca(7, 6).should eq 5
    hld.lca(0, 4).should eq 3
    hld.lca(3, 3).should eq 3
    hld.lca(2, 7).should eq 3
  end

  it "path_edge_query simple" do
    # +---+      +---+      +---+
    # | 0 |--10--| 1 |--20--| 2 |
    # +-- +      +---+      +---+

    g = Graph.new([0, [1, 2]], origin: 0)
    hld = HLDecomposition.new(g, 0)
    st = [-1, 10, 20].to_st_sum

    hld.path_query_with_st(0, 2, st).should eq 30
    hld.path_query_with_st(0, 1, st).should eq 10
    hld.path_query_with_st(1, 2, st).should eq 20
  end

  it "path_edge_query" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)
    values = Array.new(8, 0)
    hld.enter.each_with_index do |i, v|
      values[i] = (v + 1) * 10
    end
    values.should eq [40, 60, 50, 70, 80, 30, 10, 20]
    st = values.to_st_sum

    hld.path_query_with_st(2, 4, st).should eq 140
    hld.path_query_with_st(1, 7, st).should eq 190
    hld.path_query_with_st(3, 3, st).should eq 0
    hld.path_query_with_st(7, 0, st).should eq 180
    hld.path_query_with_st(6, 7, st).should eq 200
    hld.path_query_with_st(1, 0, st).should eq 30
    hld.path_query_with_st(3, 1, st).should eq 50
  end

  it "path_vertex_query" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)
    values = Array.new(8, 0)
    hld.enter.each_with_index do |i, v|
      values[i] = (v + 1) * 10
    end
    values.should eq [40, 60, 50, 70, 80, 30, 10, 20]
    st = values.to_st_sum

    hld.path_query_with_st(2, 4, st, edge: false).should eq 180
    hld.path_query_with_st(1, 7, st, edge: false).should eq 230
    hld.path_query_with_st(3, 3, st, edge: false).should eq 40
    hld.path_query_with_st(7, 0, st, edge: false).should eq 220
    hld.path_query_with_st(6, 7, st, edge: false).should eq 260
    hld.path_query_with_st(1, 0, st, edge: false).should eq 60
    hld.path_query_with_st(3, 1, st, edge: false).should eq 90
  end

  it "subtree edge query" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)
    values = Array.new(8, 0)
    hld.enter.each_with_index do |i, v|
      values[i] = (v + 1) * 10
    end
    values.should eq [40, 60, 50, 70, 80, 30, 10, 20]
    st = values.to_st_sum

    ans = 0
    hld.subtree_query(5) do |lo,hi|
      ans += st[lo..hi]
    end
    ans.should eq 200
  end

  it "subtree vertex query" do
    g = Graph.new([4, [3, 1, 2], [6, 8, [5, 7]]], origin: 1)
    hld = HLDecomposition.new(g, 3)
    values = Array.new(8, 0)
    hld.enter.each_with_index do |i, v|
      values[i] = (v + 1) * 10
    end
    values.should eq [40, 60, 50, 70, 80, 30, 10, 20]
    st = values.to_st_sum

    ans = 0
    hld.subtree_query(5, edge: false) do |lo,hi|
      ans += st[lo..hi]
    end
    ans.should eq 260
  end
end
