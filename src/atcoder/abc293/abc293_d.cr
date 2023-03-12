require "crystal/union_find"
n, m = gets.to_s.split.map(&.to_i)
uf = n.to_uf

m.times do
  a,b,c,d = gets.to_s.split
  a, c = [a,c].map(&.to_i.pred)
  uf.unite(a, c)
end

x = 0_i64
y = 0_i64

uf.group_edge_size.zip(uf.group_vertex_size).each do |e,v|
  if e >= v
    x += 1
  else
    y += 1
  end
end

puts [x, y].join(" ")
