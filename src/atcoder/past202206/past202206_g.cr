require "crystal/union_find"

n = gets.to_s.to_i
uf = n.to_uf
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

ans = uf.vertex_size(0) == n
puts ans ? "Yes" : "No"
