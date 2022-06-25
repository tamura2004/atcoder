# Lリットルで届く街と、回数１でつながるグラフを考える
# 最短パス-1が答え

require "crystal/matrix_graph/warshall_floyd"
include MatrixGraph

n,m,l = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)
m.times do
  v,nv,c = gets.to_s.split.map(&.to_i64)
  g.add v, nv, c
end

WarshallFloyd.new(g).solve

gg = Graph.new(n)
n.times do |v|
  n.times do |nv|
    next unless v < nv
    next if l < g[v][nv]
    gg.add v, nv, 1_i64, origin: 0
  end
end

WarshallFloyd.new(gg).solve

q = gets.to_s.to_i64
q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  if gg[v][nv] == INF
    pp -1
  else
    pp gg[v][nv] - 1
  end
end