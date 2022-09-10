# 色について全探索
# オイラーツアーで区間に変え、全て１のセグ木で動的に
# 部分木の大きさを取れるようにしておく
# 色をcに決め、深い順から、セグ木で部分木のサイズをとる
# -> 削除！（区間の先頭にマイナス）
# 最後に忘れずに全区間を取る

require "crystal/graph"
require "crystal/graph/depth"
require "crystal/graph/euler_tour"
require "crystal/segment_tree"

n = gets.to_s.to_i
g = Graph.new(n)
colors = gets.to_s.split.map(&.to_i.pred)

(n - 1).times do
  g.read
end
depth = Depth.new(g).solve(0)
enter, leave, events = EulerTour.new(g, 0).solve

st = (n*2).to_st_sum
enter.each do |i|
  st[i] = 1_i64
end

# 色別に深い順に頂点番号を持つ
color_group = Array.new(n) { [] of Int32 }
n.times do |v|
  color_group[colors[v]] << v
end
color_group.each do |a|
  a.sort_by!{|v|-depth[v]}
end

# 色ごとに処理
init = (n.to_i64 ** 2 + n) // 2
ans = Array.new(n, init)

n.times do |color|
  color_group[color].each do |v|
    g.each(v) do |nv|
      next if enter[nv] < enter[v]
      cnt = st[enter[nv]..leave[nv]]
      ans[color] -= (cnt ** 2 + cnt) // 2
    end
    cnt = st[enter[v]..leave[v]]
    st[enter[v]] = 1_i64 - cnt
  end
  cnt = st[0..]
  ans[color] -= (cnt ** 2 + cnt) // 2

  # 戻す。初期化でO(N)掛かるので手を抜かない
  color_group[color].each do |v|
    st[enter[v]] = 1_i64
  end
end

puts ans.join("\n")
