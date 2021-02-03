require "spec"
require "../bellman_ford"

describe Graph do
  it "usage" do
    g = Graph.new(5)
    g[0] << {0, 1, 10_i64}
    g[1] << {1, 2, -5_i64}
    g[0] << {0, 2, 6_i64}
    dp, neg = g.bellman_ford(0)
    dp[2].should eq 5
  end

  it "solve abc061d" do
    ABC061.solve(3,3,"1 2 4;2 3 3;1 3 5").should eq 7
    ABC061.solve(2,2,"1 2 1;2 1 1").should eq "inf"
    # ゴールに無関係の閉路
    ABC061.solve(4,4,"1 2 1;2 3 1;3 2 1;1 4 10").should eq 10
  end
end

module ABC061
  extend self
  def solve(n, m, edges)
    g = Graph.new(n)
    edges.split(/;/).map(&.split.map(&.to_i)).each do |(a, b, c)|
      a -= 1
      b -= 1
      c = -c
      g[a] << {a, b, c.to_i64}
    end
    d, neg = g.bellman_ford(0)
    if neg[n - 1]
      return "inf"
    else
      return -d[n - 1]
    end
  end
end
