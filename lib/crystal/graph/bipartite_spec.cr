require "spec"
require "crystal/graph"
require "crystal/graph/bipartite"

describe Bipartite do
  it "二部グラフでないなら例外" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 1
    expect_raises(Exception) {
      Bipartite.new(g).solve
    }
  end

  it "二部グラフなら白黒に塗分けた結果を返す" do
    g = Graph.new(8)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
    g.add 1, 4
    g.add 5, 6
    g.add 8, 7
    g.add 6, 7
    g.add 5, 8
    Bipartite.new(g).solve.should eq [0, 1, 0, 1, 2, 3, 2, 3]
  end
end
