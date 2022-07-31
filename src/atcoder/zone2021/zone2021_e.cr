require "crystal/abstract_graph/dijkstra"
include AbstractGraph

record V, y : Int32, x : Int32, z : Int32
record E, v : V, nv : V, cost : Int64
record S, cost : Int64, v : V do
  include Comparable(S)

  def <=>(other : self)
    cost <=> other.cost
  end
end

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }
b = Array.new(h-1) { gets.to_s.split.map(&.to_i64) }
g = Graph(V,E).new

# 左右への移動
h.times do |y|
  (w-1).times do |x|
    v = V.new y, x, 0
    nv = V.new y, x + 1, 0
    g.add v, E.new(v, nv, a[y][x])
    g.add nv, E.new(nv, v, a[y][x])
  end
end

# 上への移動
(h-1).times do |y|
  w.times do |x|
    v = V.new y, x, 0
    nv = V.new y+1,x,0
    g.add v, E.new(v,nv,b[y][x])
  end
end

# z軸への移動
h.times do |y|
  w.times do |x|
    v = V.new y, x, 0
    nv = V.new y, x, 1
    g.add v, E.new(v, nv, 1_i64)
    g.add nv, E.new(nv, v, 0_i64)
  end
end

# 下への移動
(h-1).times do |y|
  w.times do |x|
    v = V.new y + 1, x, 1
    nv = V.new y, x, 1
    g.add v, E.new(v, nv, 1_i64)
  end
end

nex = -> (s : S, e : E) {
  S.new(s.cost + e.cost, e.nv)
}

init = S.new(0_i64, V.new(0,0,0))
goal = V.new(h-1,w-1,0)

ans = Dijkstra(V,E,S).new(g, nex).solve(init)[goal]
pp ans