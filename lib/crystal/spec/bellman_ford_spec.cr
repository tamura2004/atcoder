require "spec"
require "../bellman_ford"

describe Graph do
  it "usage" do
    g = Graph.new(3)
    g.add(1,2,10)
    g.add(2,3,-5)
    g.add(1,3,6)
    dp, neg = g.bellman_ford(0)
    dp[2].should eq 5
  end

  it "solve abc061d" do
    ABC061.solve(3,3,[{1,2,4},{2,3,3},{1,3,5}]).should eq 7
    ABC061.solve(2,2,[{1,2,1},{2,1,1}]).should eq "inf"
    # ゴールに無関係の閉路
    ABC061.solve(4,4,[{1,2,1},{2,3,1},{1,4,10}]).should eq 10
  end
end

module ABC061
  extend self
  def solve(n, m, edges)
    g = Graph.new(n)
    edges.each do |a, b, c|
      g.add(a,b,-c)
    end
    d, neg = g.bellman_ford(0)
    pp! d
    pp! neg
    if neg[n - 1]
      return "inf"
    else
      return -d[n - 1]
    end
  end
end
