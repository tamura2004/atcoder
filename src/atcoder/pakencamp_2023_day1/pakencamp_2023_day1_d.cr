require "crystal/graph"
require "crystal/graph/deg"

n, m, k = gets.to_s.split.map(&.to_i64)
deg = Array.new(n, 0)
m.times do
  v, nv = gets.to_s.split.map(&.to_i64.pred)
  deg[v] += k
  deg[nv] += k
end

ans = deg.select(&.odd?).size <= 2
yesno ans
