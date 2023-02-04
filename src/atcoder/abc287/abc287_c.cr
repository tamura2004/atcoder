# 連結であり、次数が１の頂点がちょうど２つ、ほかの次数は２

require "crystal/indexable"
require "crystal/union_find"
n, m = gets.to_s.split.map(&.to_i)
quit "No" if n != m + 1

uf = n.to_uf
deg = Array.new(n, 0)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  deg[v] += 1
  deg[nv] += 1
  quit "No" if uf.same?(v, nv)
  uf.unite(v, nv)
end

cnt = deg.tally
puts cnt[1] == 2 && cnt[2] == n - 2 ? "Yes" : "No"

