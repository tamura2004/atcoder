require "crystal/weighted_pair_graph/dijkstra"
include WeightedPairGraph

MAX = 2500

n, m, s = gets.to_s.split.map(&.to_i)
g = Graph.new(false)

uvab = Array.new(m) do
  v, nv, a, b = gets.to_s.split.map(&.to_i64)
  v = v.to_i - 1
  nv = nv.to_i - 1
  {v, nv, a, b}
end

cd = Array.new(n) do
  c, d = gets.to_s.split.map(&.to_i64)
  {c, d}
end

n.times do |v|
  c, d = cd[v]

  (0...MAX).each do |gold|
    ngold = Math.min MAX, gold + c
    g.add v, gold, v, ngold, d
  end
end

m.times do |i|
  v, nv, a, b = uvab[i]

  (0..MAX).each do |gold|
    next if gold < a
    g.add v, gold, nv, gold - a, b
    g.add nv, gold, v, gold - a, b
  end
end

root = {0, Math.min(s, MAX)}
depth = Dijkstra.new(g).solve(root)
ans = Array.new(n, Int64::MAX)

depth.each do |(v, gold), time|
  chmin ans[v], time
end

puts ans[1..].join("\n")
