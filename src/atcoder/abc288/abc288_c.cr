require "crystal/union_find"

n,m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf

ans = 0_i64
m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  if uf.same?(v, nv)
    ans += 1
  end
  uf.unite(v, nv)
end

pp ans