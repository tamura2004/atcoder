# クエリ先読み
# 深さ順にまとめる
# 差分取る
require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/graph/depth"
require "crystal/segment_tree"

n = gets.to_s.to_i
g = Graph.new(n)
plist = gets.to_s.split.map(&.to_i.pred)
plist.each_with_index do |pv, v|
  g.add pv, v + 1, origin: 0
end

q = gets.to_s.to_i
qs = Array.new(n) { [] of Tuple(Int32, Int32) }

q.times do |i|
  v, d = gets.to_s.split.map(&.to_i)
  v = v.pred
  qs[d] << {v, i}
end

st = n.to_st_sum

et = HLDecomposition.new(g, 0)
enter, leave = et.enter, et.leave
depth = Depth.new(g).solve(0)
depth_hash = (0...n).group_by { |i| depth[i] }

ans = Array.new(q, 0)
n.times do |d|
  qs[d].each do |v, i|
    ans[i] -= st[enter[v]..leave[v]]
  end

  depth_hash[d]?.try &.each { |v|
    st[enter[v]] += 1
  }

  qs[d].each do |v, i|
    ans[i] += st[enter[v]..leave[v]]
  end
end

puts ans.join("\n")
