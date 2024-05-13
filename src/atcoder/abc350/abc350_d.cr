require "crystal/union_find"
n, m = gets.to_s.split.map(&.to_i64)
uf = n.to_uf
m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

ans = uf.group_parents.sum do |v|
  n = uf.v_size[v]
  n * (n - 1) // 2 - uf.e_size[v]
end

pp ans
