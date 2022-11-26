# a == 1のグラフ（上層）
# a == 0のグラフ（下層）とする
# 下層の頂点＝上層の頂点＋N
# スイッチがある場合、上層<=>下層をコスト０で移動
# ダイクストラ

require "crystal/graph"
require "crystal/graph/dijkstra"

n, m, k = gets.to_s.split.map(&.to_i)
g = Graph.new(n*2)

m.times do
  v, nv, a = gets.to_s.split.map(&.to_i64)
  if a == 1
    g.add v, nv, 1
  else
    g.add v + n, nv + n, 1
  end
end

s = gets.to_s.split.map(&.to_i)
s.each do |v|
  g.add v, v+n, 0
end

cnt = Dijkstra.new(g).solve
ans = Math.min cnt[n-1], cnt[-1]

puts ans == Dijkstra::INF ? -1 : ans