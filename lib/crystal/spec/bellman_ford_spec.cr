require "spec"
require "../bellman_ford"

describe BellmanFord do
  it "usage" do
    g = BellmanFord.new(5)
    g.add "1 2 1|2 3 1|3 4 -1|4 3 -1|2 5 -1"
    dp, neg = g.solve(0)
    dp.should eq [0, 1, -8, -7, 0]
    neg.should eq [false, false, true, true, false]
  end

  it "solve abc061d" do
    ABC061.solve(3, 3, "1 2 4|2 3 3|1 3 5").should eq 7
    ABC061.solve(2, 2, "1 2 1|2 1 1").should eq "inf"
    # ゴールに無関係の閉路
    ABC061.solve(4, 4, "1 2 1|2 3 1|1 4 10").should eq 10
  end
end

module ABC061
  extend self

  def solve(n, m, edges)
    g = BellmanFord.new(n)
    g.add edges

    n.times do |i|
      g.g[i] = g.g[i].map { |nv, cost| {nv, -cost} }
    end

    d, neg = g.solve(0)
    return neg[-1] ? "inf" : -d[-1]
  end
end
