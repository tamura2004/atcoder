require "crystal/graph"
require "crystal/graph/dijkstra"

# siを超頂点m..m+nとする

n, m = gets.to_s.split.map(&.to_i64)
g = Graph.new(n+m)
n.times do |i|
  v = m + i

  a = gets.to_s.to_i64
  s = gets.to_s.split.map(&.to_i64)
  s.each do |nv|
    nv -= 1
    g.add v, nv, 1_i64, origin: 0, both: false
    g.add nv, v, 0_i64, origin: 0, both: false
  end
end

ans = Dijkstra.new(g).solve
puts ans[m-1] == Dijkstra::INF ? -1 : ans[m-1].pred
