require "crystal/graph/scc"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv, both: false
end

cg,cs,ix = SCC.new(g).solve

ans = cs.map(&.size).map{|n| n.to_i64 * (n - 1) // 2}.sum
pp ans
  