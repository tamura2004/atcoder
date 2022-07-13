require "crystal/flow_graph/dinic"
include FlowGraph

g = Graph(Int64).new(4)
g.add 0, 1, 10
g.add 0, 2, 1
g.add 1, 3, 8
g.add 2, 3, 4

pp Dinic(Int64).new(g).solve
g.debug