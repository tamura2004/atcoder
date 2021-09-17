require "spec"
require "crystal/graph/shortest_path"

describe ShortestPath do
  it "頂点1からnまでの最短路のパスを求める" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 4, 5
    g.add 3, 6
    g.add 5, 6
    # 1-2-4-5-6
    #    `-3-/
    solver = ShortestPath.new(g)
    solver.solve.should eq [0, 1, 2, 5]
    solver.solve.should eq [0, 1, 2, 5] # 再実行可能
  end

  it "削除辺を指定して最短路のパスを求める" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 4, 5
    g.add 3, 6
    g.add 5, 6
    # 1-2-4-5-6
    #    `-3-/
    ShortestPath.new(g).solve(dv: 1, dnv: 2).should eq [0, 1, 3, 4, 5]
  end

  it "削除辺を指定して最短路のパスを求める" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 4, 5
    g.add 3, 6
    g.add 5, 6
    # 1-2-4-5-6
    #    `-3-/
    ShortestPath.new(g).solve(dv: 0, dnv: 1).should eq nil
  end

  it "最短路が無い（連結でない）場合はnilを返す" do
    g = Graph.new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 4, 3
    g.add 3, 1
    g.add 5, 6
    ShortestPath.new(g).solve.should eq nil
  end
end
