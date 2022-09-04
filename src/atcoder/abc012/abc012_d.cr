require "crystal/graph/matrix_graph"
require "crystal/graph/warshall_floyd"

n, m = gets.to_s.split.map(&.to_i)
g = MatrixGraph.new(n)
m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end

WarshallFloyd.new(g).solve

ans = n.times.min_of do |i|
  n.times.max_of do |j|
    g.get(i,j)
  end
end

pp ans
