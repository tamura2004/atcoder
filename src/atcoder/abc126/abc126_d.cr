require "crystal/graph"

n = gets.to_s.to_i
g = Graph.new(n)

(n-1).times do
  g.read
end

ans = Problem.new(g).solve
puts ans.join("\n")

class Problem
  getter g : IGraph
  delegate n, to: g
  getter dp : Array(Int32)
  
  def initialize(@g)
    g.tree!
    @dp = Array.new(n, -1)
  end

  def solve
    dfs(0, -1, 0)
    dp
  end

  def dfs(v,pv,color)
    dp[v] = color
    g.each_with_cost(v) do |nv, cost|
      next if nv == pv
      ncolor = cost.odd? ? 1 - color : color
      dfs(nv,v,ncolor)
    end
  end
end
