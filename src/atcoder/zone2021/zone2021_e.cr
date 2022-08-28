require "crystal/graph/generic_vertex_graph"
require "crystal/graph/dijkstra"

alias V = Tuple(Int32, Int32, Int32)
# record V, y : Int32, x : Int32, z : Int32
# record E, v : V, nv : V, cost : Int64
# record S, cost : Int64, v : V do
#   include Comparable(S)

#   def <=>(other : self)
#     cost <=> other.cost
#   end
# end

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }
b = Array.new(h - 1) { gets.to_s.split.map(&.to_i64) }
g = GenericVertexGraph(V).new

# 左右への移動
h.times do |y|
  (w - 1).times do |x|
    # v = V.new y, x, 0
    # nv = V.new y, x + 1, 0
    # g.add v, E.new(v, nv, a[y][x])
    # g.add nv, E.new(nv, v, a[y][x])
    v = {y, x, 0}
    nv = {y, x + 1, 0}
    g.add v, nv, a[y][x], both: false
    g.add nv, v, a[y][x], both: false
  end
end

# 上への移動
(h - 1).times do |y|
  w.times do |x|
    # v = V.new y, x, 0
    # nv = V.new y+1,x,0
    # g.add v, E.new(v,nv,b[y][x])
    v = {y, x, 0}
    nv = {y + 1, x, 0}
    g.add v, nv, b[y][x], both: false
  end
end

# z軸への移動
h.times do |y|
  w.times do |x|
    # v = V.new y, x, 0
    # nv = V.new y, x, 1
    # g.add v, E.new(v, nv, 1_i64)
    # g.add nv, E.new(nv, v, 0_i64)
    v = {y, x, 0}
    nv = {y, x, 1}
    g.add v, nv, 1_i64, both: false
    g.add nv, v, 0_i64, both: false
  end
end

# 下への移動
(h - 1).times do |y|
  w.times do |x|
    # v = V.new y + 1, x, 1
    # nv = V.new y, x, 1
    # g.add v, E.new(v, nv, 1_i64)
    v = {y + 1, x, 1}
    nv = {y, x, 1}
    g.add v, nv, 1_i64, both: false
  end
end

# nex = -> (s : S, e : E) {
#   S.new(s.cost + e.cost, e.nv)
# }

root = g.ix[{0, 0, 0}]
goal = g.ix[{h - 1, w - 1, 0}]

# g.each do |v|
#   puts "#{v}: #{g.vs[v]}"
#   g.each_with_cost(v) do |nv, cost|
#     puts " -> #{nv}: #{g.vs[nv]}, cost: #{cost}"
#   end
# end

ans = Dijkstra.new(g).solve(root)[goal]
pp ans
