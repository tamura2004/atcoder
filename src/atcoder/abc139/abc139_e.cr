# 試合＝タプルを頂点としたグラフにおいて
# 閉路が無いことが成立条件
# トポロジカルソートしてＤＰすると最長パスが求められるが
# それが試合日数になる

require "crystal/abstract_graph/tsort"

struct V
  getter i : Int32
  getter j : Int32

  def initialize(@i, @j)
    @i, @j = j, i if i > j
  end
end

n = gets.to_s.to_i64
g = Graph(V).new

(1..n).each do |i|
  a = gets.to_s.split.map(&.to_i)

  a.each do |j|
    g.add_vertex V.new(i, j)
  end

  a.each_cons_pair do |j, k|
    g.add V.new(i, j), V.new(i, k)
  end
end

if ans = Tsort(V).new(g).longest_path
  pp ans.values.max + 1
else
  pp -1
end
