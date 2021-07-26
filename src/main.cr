require "crystal/tree"
require "crystal/segment_tree"

tr = Tree.new(5) do |tr|
  tr.add 1, 3
  tr.add 1, 4
  tr.add 4, 2
  tr.add 4, 5
end

lca = tr.lca
pp lca.call(1,4)
pp lca.call(4,1)
pp lca.call(2,4)
pp lca.call(4,2)
