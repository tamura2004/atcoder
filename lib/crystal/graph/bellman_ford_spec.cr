require "spec"
require "crystal/graph/graph"
require "crystal/graph/bellman_ford"

describe BellmanFord do
  # ベルマンフォード法により最短経路を求める
  #
  # 負閉路に含まれる点[3][4]を持つ場合
  #             +-----+
  #             |  1  |
  #             +-----+
  #               |
  #               | 1
  #               v
  # +---+  -1   +-----+
  # | 5 | <---- |  2  |
  # +---+       +-----+
  #               |
  #               | 1
  #               v
  #             +-----+
  #             |  3  | <+
  #             +-----+  |
  #               |      |
  #               | -1   | -1
  #               v      |
  #             +-----+  |
  #             |  4  | -+
  #             +-----+
  # ```
  # g = Graph.new(5)
  # g.add 1, 2, 1
  # g.add 2, 3, 1
  # g.add 3, 4, -1
  # g.add 4, 3, -1
  # g.add 2, 5, -1
  # dp, neg = g.bellman_ford(0)
  # dp  # => [0, 1, -8, -7, 0]
  # neg #
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, 1, both: false
    g.add 2, 3, 1, both: false
    g.add 3, 4, -1, both: false
    g.add 4, 3, -1, both: false
    g.add 2, 5, -1, both: false
    dp, neg = BellmanFord.new(g).solve
    dp.should eq [0, 1, -8, -7, 0]
    neg.should eq [false, false, true, true, false]
  end
end
