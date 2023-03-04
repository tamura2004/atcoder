require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf
m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

ans = uf.group_parents.all? do |i|
  uf.edge_size(i) == uf.vertex_size(i)
end

puts ans ? :Yes : :No