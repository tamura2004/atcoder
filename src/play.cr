require "crystal/tree"

g = Tree.make(5, :bus)
g.debug(1)

pp g.depth(root = 0, offset = 1)
pp g.depth_count(root = 0, offset = 1)