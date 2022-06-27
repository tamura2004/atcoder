require "crystal/graph"

INF = 1e6.to_i

n,m = gets.to_s.split.map(&.to_i)
g = Graph.new(n+1)
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, origin: 0
end

from_root = ShortestPath.new(g).solve(1)
from_goal = ShortestPath.new(g).solve(n)

ans = Array.new(n, INF)

(1..n).each do |i|
  chmin ans[i-1], from_root[n]
  chmin ans[i-1], from_root[0] + from_goal[i]
  chmin ans[i-1], from_root[i] + from_goal[0]
  ans[i-1] = -1 if ans[i-1] == INF
end

puts ans.join(" ")

class ShortestPath
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve(root = 0)
    depth = Array.new(n, INF)
    q = Deque.new([root])
    depth[root] = 0

    while q.size > 0
      v = q.shift

      g[v].each do |nv|
        next if depth[nv] != INF
        depth[nv] = depth[v] + 1
        q << nv
      end
    end
    depth
  end
end
