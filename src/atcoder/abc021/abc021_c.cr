# a->bの最短路長さをnとする
# 隣接行列のn乗でのa->bが答え

require "crystal/graph/shortest_path"
require "crystal/matrix"
require "crystal/mod_int"

n = gets.to_s.to_i
root, goal = gets.to_s.split.map(&.to_i.pred)

g = Graph.new(n)
mt = Matrix(ModInt).zero(n)

m = gets.to_s.to_i
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
  v = v.to_i - 1
  nv = nv.to_i - 1
  mt[v,nv] = 1.to_m
  mt[nv,v] = 1.to_m
end

path = ShortestPath.new(g).solve(root, goal)
ans = mt ** (path.not_nil!.size - 1)
pp ans[root,goal]