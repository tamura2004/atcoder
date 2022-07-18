require "crystal/flow_graph/dinic"

n,m = gets.to_s.split.map(&.to_i64)
g = Graph.new(n*2+2)

root = 0
goal = n*2+1

c = gets.to_s.split.map(&.to_i64)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  g.add v * 2 + 2, nv * 2 + 1, INF
end

(n-2).times do |i|
  v = (i+1)*2+1
  nv = (i+1)*2+2

  if c[i] >= 0
    g.add v, nv, c[i]
  else
    g.add root, nv, INF
    g.add v, goal, INF
  end
end

ans = Dinic.new(g).solve(root, goal)
pp ans == INF ? -1 : ans
