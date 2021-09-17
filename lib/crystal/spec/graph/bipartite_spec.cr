require "spec"
require "crystal/graph/bipartite"

describe Bipartite do
  it "二部グラフでないならnilを返す" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 1
    Bipartite.new(g).solve.should eq nil
  end

  it "二部グラフなら白黒に塗分けた結果を返す" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
    Bipartite.new(g).solve.should eq [0, 1, 0, 1]
  end
end
