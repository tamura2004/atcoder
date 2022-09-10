require "crystal/graph"

g = Graph.new([1, [2, [3, 6], 4, 5], [7, 8]])
n = g.n

dp = Array.new(n) { [] of Bool }

