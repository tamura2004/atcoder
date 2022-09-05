require "crystal/graph"

g = Graph.new([2,[0,6,7,1],[3,4,5]], origin: 0)
pp g
pp g.to_sexp
