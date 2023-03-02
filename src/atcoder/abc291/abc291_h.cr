require "crystal/graph"
require "crystal/centroid_decomposition"

n = gets.to_s.to_i64
g = n.to_g
(n-1).times do
  g.read
end

cd = CentroidDecomposition.new(g)
cd.build!
puts cd.centroid_tree.to_plist.join(" ")