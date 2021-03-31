require "crystal/weighted_graph"

class Main < WeightedGraph
  getter dp : Array(Int32)

  def initialize(@n)
    super(n)
    @dp = Array.new(n, 0)
  end

  def dfs(v, pv)
    return 0 if g[v].size == 1 && pv != -1

    dp[v] = g[v].max_of do |nv, cost|
      next 0 if nv == pv
      dfs(nv, v) + cost
    end
  end

end

g = Main.new(4)
g.add "0 1 1;1 2 2;2 3 4", origin: 0, both: true
g.dfs(0,-1)

pp! g

# [0]--1--[1]--2--[2]--4--[3]
