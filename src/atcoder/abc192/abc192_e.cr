require "crystal/priority_queue"
require "crystal/graph/i_graph"
require "crystal/graph"
require "crystal/indexable"

# ダイクストラ法により、正の重み付きグラフの
# 一点開始、全点への最短距離を求める
class Dijkstra
  INF = Int64::MAX // 4

  getter g : IGraph
  delegate n, to: g
  getter mod : Array(Int64)

  def initialize(@g, @mod)
  end

  def solve(root = 0)
    q = [{0_i64, root}].to_pq_lesser
    seen = Array.new(n, false)
    depth = Array.new(n, INF)

    while q.size > 0
      cost, v = q.pop
      next if seen[v]
      seen[v] = true
      depth[v] = cost

      g.each_cost_with_index(v) do |nv, ncost, i|
        next if seen[nv]
        nex = divceil(cost, mod[i]) * mod[i] + ncost
        q << {nex, nv}
      end
    end

    depth
  end
end

n,m,x,y = gets.to_s.split.map(&.to_i)
x-=1
y-=1
g = Graph.new(n)
mod = [] of Int64
m.times do |i|
  v,nv,t,k = gets.to_s.split.map(&.to_i64)
  v = v.to_i
  nv = nv.to_i
  g.add v, nv, t
  mod << k
end

depth = Dijkstra.new(g, mod).solve(x)
ans = depth[y]
puts ans == Dijkstra::INF ? -1 : ans