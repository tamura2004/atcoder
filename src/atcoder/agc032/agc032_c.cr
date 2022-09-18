require "crystal/flow_graph/dinic"
include FlowGraph

n,m = gets.to_s.split.map(&.to_i)
edges = Array.new(m) do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  {v, nv}
end

deg = Array.new(n, 0)
edges.each do |v, nv|
  deg[v] += 1
  deg[nv] += 1
end

quit "No" if deg.any?(&.odd?)
quit "Yes" if deg.count(&.>= 6) > 0
quit "Yes" if deg.count(&.>= 4) > 2
quit "No" if deg.count(&.>= 4) <= 1

root = goal = -1
n.times do |v|
  next if deg[v] < 4
  if root == -1
    root = v
  else
    goal = v
  end
end

g = Graph.new(n)
edges.each do |v, nv|
  g.add v, nv, 1, origin: 0
  g.add nv, v, 1, origin: 0
end

cnt = Dinic.new(g).solve(root, goal)

# pp! [root, goal]
# pp! cnt 
puts cnt == 2 ? "Yes" : "No"
