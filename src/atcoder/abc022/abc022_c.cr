require "crystal/matrix_graph/warshall_floyd"
include MatrixGraph

INF = 1e10.to_i64

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
nbr = Array.new(n, INF)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v, nv = {v,nv}.map(&.pred)
  if v.zero?
    nbr[nv] = cost
  else
    g.add v, nv, cost, origin: 0
  end
end

WarshallFloyd.new(g).solve

ans = INF
n.times do |i|
  n.times do |j|
    next if i == j
    chmin ans, nbr[i] + nbr[j] + g[i][j]
  end
end

pp ans < INF ? ans : -1
