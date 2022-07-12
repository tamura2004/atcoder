require "crystal/flow_graph/dinic"
include FlowGraph

INF = 1e15.to_i64

n = 5
edges = [
  {0,1,100},
  {0,4,99},
  {2,5,90},
  {3,5,101},
  {1,3,INF},
  {1,4,100},
  {2,3,99},
  {2,4,INF}  
]

g = Graph(Int64).new(n+1)
edges.each do |v, nv, cost|
  g.add v, nv, cost
end

pp Dinic(Int64).new(g).solve