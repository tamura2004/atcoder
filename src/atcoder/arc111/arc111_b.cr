# 色を頂点として、裏表の頂点を結んだグラフを考える
# 連結成分のMin(辺数、頂点数)の合計が答え
# UnionFind

require "crystal/union_find"
N = 400_000

n = gets.to_s.to_i64
uf = N.to_uf

n.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  uf.unite v, nv
end

ans = 0_i64
N.times do |v|
  if v == uf.find(v)
    ans += Math.min uf.size(v), uf.edge_size(v)
  end
end

pp ans