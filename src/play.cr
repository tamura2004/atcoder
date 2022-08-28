require "crystal/graph"

g = Graph.new(5)
g.add 1, 2, both: false, origin: 0
g.add 1, 3, both: false, origin: 0
g.add 3, 4, both: false, origin: 0
puts g