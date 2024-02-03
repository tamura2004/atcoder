require "crystal/graph"
require "crystal/graph/subtree_size"

n = gets.to_s.to_i64
g = n.to_g
(n-1).times do
  g.read
end

ss = SubtreeSize.new(g).solve(0)
cnt = g.each(0).map{|i| ss[i]}.to_a
ans = cnt.sum - cnt.max

puts ans + 1