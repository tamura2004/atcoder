require "crystal/graph/matrix_graph"
require "crystal/graph/warshall_floyd"
require "crystal/graph/tsp"

n, m = gets.to_s.split.map(&.to_i)
g = n.to_g

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, both: false
end

WarshallFloyd.new(g).solve

dp = make_array(INF,  1 << n, n)
n.times do |v|
  dp[1<<v][v] = 0_i64
end

Tsp.new(g).solve(dp)

ans = dp[-1].min
puts ans == INF ? :No : ans
