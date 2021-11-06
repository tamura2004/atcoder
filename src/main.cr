require "crystal/bit_set"
require "crystal/matrix_graph/graph"
include MatrixGraph

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  v,nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

clique = Array.new(1<<n, false)
(1<<n).times do |s|
  clique[s] = s.elements.all? do |i|
    s.elements.all? do |j|
      i == j || g[i][j] == 1
    end
  end
end

pp clique.zip(0..)
