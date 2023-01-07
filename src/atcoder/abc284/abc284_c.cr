require "crystal/union_find"

n,m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf
m.times do
  v,nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

pp uf.size