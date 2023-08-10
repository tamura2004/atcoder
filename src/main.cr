require "crystal/union_find"
n, m = gets.to_s.split.map(&.to_i)
uf = n.to_uf

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

good = Set({Int32,Int32}).new
k = gets.to_s.to_i
k.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  v = uf.find(v)
  nv = uf.find(nv)
  good << {v, nv}
  good << {nv, v}
end

q = gets.to_s.to_i
q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  v = uf.find(v)
  nv = uf.find(nv)
  puts good.includes?({v, nv}) ? :No : :Yes
end
