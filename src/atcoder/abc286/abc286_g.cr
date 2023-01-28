require "crystal/union_find"

n,m = gets.to_s.split.map(&.to_i)
edges = Array.new(m) do
  gets.to_s.split.map(&.to_i.pred)
end
k = gets.to_s.to_i
s = gets.to_s.split.map(&.to_i.pred)
t = (0...m).to_a - s

uf = n.to_uf

t.each do |i|
  v, nv = edges[i]
  uf.unite(v, nv)
end

deg = Array.new(n, 0_i64)
s.each do |i|
  edges[i].each do |v|
    deg[uf.find(v)] += 1
  end
end

cnt = deg.count(&.odd?)
puts cnt == 0 || cnt == 2 ? :Yes : :No
