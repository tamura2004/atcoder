require "crystal/weighted_pair_graph/dijkstra"
include WeightedPairGraph

n, m, s = gets.to_s.split.map(&.to_i)
chmin s, 2500
g = Graph.new(both: false)
m.times do
  v, nv, a, b = gets.to_s.split.map(&.to_i64)
  v = v.to_i - 1
  nv = nv.to_i - 1

  (0..2500).each do |c|
    nc = c + a
    next if 2500 < nc

    g.add v, nc, nv, c, b
    g.add nv, nc, v, c, b
  end
end

n.times do |v|
  a, d = gets.to_s.split.map(&.to_i64)
  2500.times do |c|
    nc = c + a
    next if 2500 < nc
    g.add v, c, v, nc, d
  end
end

cnt = Dijkstra.new(g).solve({0, s})
ans = Array.new(n, Int64::MAX)
cnt.each do |(v, _), cost|
  # pp! [v, cost] if v != 0
  chmin ans[v], cost
end

puts ans[1..].join("\n")
