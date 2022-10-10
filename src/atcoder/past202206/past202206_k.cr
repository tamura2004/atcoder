require "crystal/graph"
require "crystal/graph/dijkstra"

n, m, q, k = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
a = gets.to_s.split.map(&.to_i.pred)

m.times do
  g.read
end

dp = Array.new(k) do |i|
  Dijkstra.new(g).solve(a[i])
end

q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  ans = k.times.min_of do |i|
    dp[i][v] + dp[i][nv]
  end
  pp ans
end
