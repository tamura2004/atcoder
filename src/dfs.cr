require "crystal/graph"
require "crystal/graph/grid"
require "crystal/graph/weighted_graph"
require "crystal/graph/depth"
require "crystal/graph/dijkstra"

g = Graph.new(3)
g.add 1, 2
g.add 2, 3
pp! g
pp Depth.new(g).solve

g = Grid.new(2, 3, [".#.", "..."])
pp! g
pp Depth.new(g).solve

g = WeightedGraph.new(3)
g.add 1, 2, 3
g.add 2, 3, 4
pp! g
pp Depth.new(g).solve
pp Dijkstra.new(g).solve
