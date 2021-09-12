require "spec"
require "../graph/bridge"

describe Bridge do
  it "橋を列挙する" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
    g.add 4, 5
    g.add 5, 6
    g.add 6, 3
    Bridge.new(g).solve.should eq [{1, 2}, {0, 1}]
  end

  it "橋がないなら、空配列を返す" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
    g.add 4, 5
    g.add 5, 6
    g.add 6, 1
    Bridge.new(g).solve.should eq [] of Tuple(Int32,Int32)
  end
end
