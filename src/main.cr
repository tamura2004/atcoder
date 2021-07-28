require "crystal/tree"

tr = Tree.make(200000)
centroid, trees = tr.centroid_decomposition
pp centroid