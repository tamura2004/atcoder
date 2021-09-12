require "crystal/graph/bipartite"

g = Graph.new(3)
g.add 1, 2
g.add 2, 3
g.add 1, 3

pp Bipartite.new(g).solve

