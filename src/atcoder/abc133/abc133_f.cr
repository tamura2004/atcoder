# u-v間のパス長|uv|は、根をr,LCAをpとすると
# |ru| + |rv| - 2|rp|
# 各頂点での、色の出現頻度cと、色の累積長さxがわかれば、
# 長さをx->yに変えた時の長さは、|uv|' = |uv| - x + cy
# dfsで調べて回ることはできるが、空間計算量N^2となりMLE
# 同じ配列に記録しながらdfsで更新し、クエリ先読みをしておいて
# 必要な値を都度記録する。

require "crystal/weighted_tree/lca"
include WeightedTree

struct Query
  property u : Int32
  property v : Int32
  property x : Int32
  property y : Int64

  def initialize(@u, @v, @x, @y)
  end
end

getter g : Graph
delegate n, to: g

n,q = gets.to_s.split.map(&.to_i)
len = Array.new(n, 0_i64)
t = Tree.new(n)
g = Array.new(n) { [] of Tuple(Int64,Int64) }

# (n-1).times do
#   a,b,c,d = gets.to_s.split.map(&.to_i64)
#   t.add a,b,c

#   a = a.to_i.pred
#   b = b.to_i.pred
#   g[a] << {c,d}
#   g[b] << {c,d}
# end

# lca = Lca.new(t).solve

# record Ans, u : Int32, v : Int32, p : Int32, x : Int32, y : Int64

# ans = Array.new(q) { Ans.new(-1,-1,-1,-1,0_i64) }
# event = Array.new(n) { [] of Int32 }

# q.times do |i|
#   x,y,u,v = gets.to_s.split.map(&.to_i64)
#   u = u.to_i.pred
#   v = v.to_i.pred

#   ans[i][0] = u
#   ans[i][1] = v
#   ans[i][2] = lca.call(u,v)
#   ans[i][3] =
