# 与えられたグラフはDAG
# トポロジカルソートしてdp
# dp[v] := 最長パス
# dp <- 0
# chmax dp[nv], dp[v] + 1

require "crystal/graph"
require "crystal/graph/tsort"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end
dp = make_array(0_i64, n)
Tsort.new(g).solve?.not_nil!.each do |v|
  g.each(v) do |nv|
    chmax dp[nv], dp[v] + 1
  end
end
pp dp.max
