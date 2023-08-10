require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i)
uf = n.to_uf
edges = [] of Tuple(Int32,Int32)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  edges << { v, nv }
end

c = gets.to_s.split.map(&.to_i)

edges.each do |v, nv|
  next if c[v] == c[nv]
  uf.unite(v, nv)
end

edges.each do |v, nv|
  next if c[v] != c[nv]
  quit :Yes if uf.find(v) == uf.find(nv)
end

puts :No
