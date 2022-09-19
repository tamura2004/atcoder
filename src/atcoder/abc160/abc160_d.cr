require "crystal/graph"
require "crystal/graph/dijkstra"

n, x, y = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

(n-1).times do |v|
  g.add v, v+1, origin: 0
end
g.add x, y, origin: 1

ans = Array.new(n, 0)

g.each do |v|
  dep = Dijkstra.new(g).solve(v)
  (v+1...n).each do |nv|
    ans[dep[nv]] += 1
  end
end

puts ans[1..].join("\n")