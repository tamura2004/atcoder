require "crystal/graph/shortest_path"
require "crystal/graph/bridge"

n, m = gets.to_s.split.map(&.to_i)
edges = Array.new(m) do
  v, nv = gets.to_s.split.map(&.to_i.- 1)
  { v, nv }
end

ix = Hash(Tuple(Int32,Int32),Int32).new
m.times do |i|
  v, nv = edges[i]
  ix[{v,nv}] = i
end

g = Graph.new(n, m) do |g, i|
  v, nv = edges[i]
  g.add v, nv, origin = 0
end

path = ShortestPath.new(g).solve
bridge = Bridge.new(g).solve

pp path
pp bridge