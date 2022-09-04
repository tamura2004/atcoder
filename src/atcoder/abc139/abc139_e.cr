# 試合＝タプルを頂点としたグラフにおいて
# 閉路が無いことが成立条件
# トポロジカルソートしてＤＰすると最長パスが求められるが
# それが試合日数になる

require "crystal/graph"
require "crystal/graph/tsort"

alias V = Tuple(Int32, Int32)

n = gets.to_s.to_i
g = BaseGraph(V).new

n.times do |a|
  gets.to_s.split.map(&.to_i.pred).each_cons_pair do |b, c|
    v = ({a, b}).minmax
    nv = ({a, c}).minmax
    g.add v, nv, both: false
  end
end

if path = Tsort.new(g).solve?
  dp = Array.new(g.n, 1)
  path.each do |v|
    g.each(v) do |nv|
      chmax dp[nv], dp[v] + 1
    end
  end
  puts dp.max
else
  puts -1
end
