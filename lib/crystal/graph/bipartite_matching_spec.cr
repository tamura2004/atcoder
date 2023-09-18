require "spec"
require "crystal/graph"
require "crystal/graph/bipartite_matching"

describe BipartiteMatching do
  it "usage" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 4, 5
    g.add 4, 6
    BipartiteMatching.new(g).solve.should eq({2, [1, 0, -1, 4, 3, -1]})
  end

  it "easy" do
    BipartiteMatching.new(
      [
        {1, 1},
        {1, 2},
        {2, 1},
        {2, 2},
      ]
    ).solve.first.should eq 2
  end

  # it "https://qiita.com/drken/items/e805e3f514acceb87602" do
  #   BipartiteMatching.new(
  #     [
  #       {1, 1},
  #       {2, 2},
  #       {2, 4},
  #       {2, 5},
  #       {3, 6},
  #       {4, 3},
  #       {5, 3},
  #       {6, 6},
  #     ]
  #   ).solve.tap { |ans| pp! ans }.first.should eq 4
  # end

  # it "https://manabitimes.jp/math/1147" do
  #   BipartiteMatching.new(
  #     [
  #       {1, 2},
  #       {2, 1},
  #       {2, 2},
  #       {2, 3},
  #       {2, 4},
  #       {3, 2},
  #       {4, 2},
  #       {5, 1},
  #     ]
  #   ).solve.first.should eq 3
  # end
end
