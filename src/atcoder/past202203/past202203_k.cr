require "crystal/weighted_graph/dijkstra"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
rg = Graph.new(n)

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost, both: false
  rg.add nv, v, cost, both: false
end

fw = Dijkstra.new(g).solve(0)
bk = Dijkstra.new(rg).solve(n-1)

n.times do |i|
  if fw[i] == INF || bk[i] == INF
    puts -1
  else
    puts fw[i] + bk[i]
  end
end
