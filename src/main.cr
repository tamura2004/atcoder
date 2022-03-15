require "crystal/tree/lca"

n = 5
g = Tree.new(n)
g.add 1, 2
g.add 1, 3
g.add 2, 4
g.add 2, 5

lca = Lca.new(g).solve
pa = Parent.new(g).solve
