require "crystal/graph"

pp Graph.from_sexp([8,[2,6,7,1],[3,4,5]])
pp Graph.from_pa([-1,0,1,1,1])