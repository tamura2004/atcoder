require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i)
uf = n.to_uf

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

ans = Set(Int32).new
n.times do |v|
  if uf.vertex_size(v) - 1 == uf.edge_size(v)
    ans << uf.find(v)
  end
end

puts ans.size