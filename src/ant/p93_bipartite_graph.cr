require "crystal/graph"

g = Graph.new(4)
g.add_edge("0 1;0 3;2 1;2 3")
puts g.is_bipartite? ? "Yes" : "No"
