require "crystal/tree"

# n, qn = gets.to_s.split.map(&.to_i)
# g = Tree.new(n) do |g|
#   (n-1).times do
#     v, nv = gets.to_s.split.map(&.to_i)
#     g.add v, nv
#   end
# end

# g.debug(1)

# q = Deque.new([g])
# while tr = q.shift?
#   c, trees = tr.centroid_decomposition
#   next if trees.first.empty?
#   q << trees.first.first
# end

g = Tree.new(1)
g.debug
pp! g.depth
pp! g.parent
pp! g.degree
pp! g.euler_tour
pp! g.subtree
pp! g.children
pp! g.centroid
pp! g.centroid_decomposition