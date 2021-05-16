require "spec"
require "../weighted_tree"

describe WeightedTree do
  it "usage bfs" do
    g = WeightedTree.new(3)

    g.add 1, 2, 10, both: true, origin: 1
    g.add 2, 3, 20, both: true, origin: 1

    dp = Array.new(3, -1)
    dp[0] = 0

    g.bfs do |v, nv, w, q|
      next if dp[nv] != -1
      dp[nv] = dp[v] + w
      q << nv
    end
    
    dp.should eq [0, 10, 30]
  end
end
