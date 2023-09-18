require "spec"
require "crystal/flow_graph/max_bipartite_matching"
include FlowGraph

describe FlowGraph::MaxBipartiteMatching do
  it "https://qiita.com/drken/items/e805e3f514acceb87602" do
    MaxBipartiteMatching.new(
      [
        {1, 1},
        {2, 2},
        {2, 4},
        {2, 5},
        {3, 6},
        {4, 3},
        {5, 3},
        {6, 6},
      ]
    ).solve.should eq 4
  end

  it "https://manabitimes.jp/math/1147" do
    MaxBipartiteMatching.new(
      [
        {1, 2},
        {2, 1},
        {2, 2},
        {2, 3},
        {2, 4},
        {3, 2},
        {4, 2},
        {5, 1},
      ]
    ).solve.should eq 3
  end

  it "比較可能であればよい" do
    MaxBipartiteMatching.new(
      [
        {'A', {1, 1}},
        {'A', {1, 2}},
        {'B', {1, 1}},
        {'B', {1, 2}},
      ]
    ).solve.should eq 2
  end
end
