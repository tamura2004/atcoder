require "crystal/union_find"
require "crystal/graph/triangle"
require "crystal/fenwick_tree"

n,m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

y = Array.new(n) { gets.to_s.to_i }
if inversion_number(y).odd?
  puts "NO"
  exit
end

uf = n.to_uf
Triangle.new(g).solve.each do |i,j,k|
  uf.unite i,j
  uf.unite j,k
end

ans = n.times.all? do |i|
  uf.same? i, y[i] - 1
end

puts ans ? "YES" : "NO"
