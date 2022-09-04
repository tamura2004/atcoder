# 木の直径上にある？（ない）反例
# 7から距離1は8
# 1 - 2 - 3 - 4 - 5 - 6
#         |
#     7 - 8
#
# そもそも根付き木の場合を考える
# 根の方向へ距離kの点は、ダブリングでO(LogN)で求められる（ex:LCA）
# ある点からの最大距離の点は、直径の両端に限られる
#
# 10より距離6の点は？だけど、a-9が直径
#
#                10
#                 |
# 1 - 2 - 3 - 4 - 5 - 6 - 7 - 8 - 9
#                 |
# a - b - c - d - e
#
# 直径の両端を根とする二つの根付き木について、
# 与えられた点uから根方向へk移動した点を求めれば良い
# どちらの深さよりkが大きいならそのような点は存在しない

require "crystal/graph"
require "crystal/graph/diameter"
require "crystal/graph/parent"

n = gets.to_s.to_i
g = Graph.new(n)
(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

# puts g

a, b = Diameter.new(g).solve
ap = Parent.new(g, a)
bp = Parent.new(g, b)

# puts ap.pa.first(3).map(&.join(" ")).join("\n")

q = gets.to_s.to_i
q.times do
  v, k = gets.to_s.split.map(&.to_i)
  v -= 1
  ans = [ap, bp].max_of do |pp|
    # pp! [v,k,pp.up(v, k)]
    pp.up(v, k)
  end
  pp ans == -1 ? -1 : ans + 1
end
