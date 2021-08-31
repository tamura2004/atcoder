require "crystal/bellman_ford"

g = BellmanFord.new(6)
g.add 1,2,1
g.add 2,5,-1
g.add 2,3,1
g.add 3,4,-1
g.add 4,3,-1

dp, neg = g.solve(0)
pp dp
pp neg