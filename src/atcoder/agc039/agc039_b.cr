require "crystal/graph/matrix_graph"
require "crystal/graph/bipartite"
require "crystal/graph/warshall_floyd"

n = gets.to_s.to_i
g = MatrixGraph.new(n)
n.times do |v|
  s = gets.to_s
  n.times do |nv|
    if s[nv] == '1'
      g.add v, nv, origin: 0
    end
  end
end
quit -1 unless Bipartite.new(g).solve
WarshallFloyd.new(g).solve

ans = (g.g.flatten - [MatrixGraph::INF]).max
pp ans + 1
