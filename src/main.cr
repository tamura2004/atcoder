require "crystal/flow_graph/max_flow"
include FlowGraph

N = 8000_i64
s = N*2
t = s + 1

g = Graph.new(N*2 + 2)

n = gets.to_s.to_i64
xyz = Array.new(n) do
  x, y, z = gets.to_s.split.map(&.to_i64)
  {x, y, z}
end

edges = Set(Tuple(Int64, Int64)).new
vertexes = Set(Int64).new

xyz.each do |x, y, z|
  3.times do
    x, y, z = y, z, x
    (x - 1).times do |i|
      v = y * z * (i + 1)
      nv = y * z * (x - 1 - i)
      edges << {v, nv}
      vertexes << v
      vertexes << nv
    end
  end
end

vertexes.each do |v|
  g.add s, v, 1
  g.add v + N, t, 1
end

edges.to_a.sort.each do |v, nv|
  g.add v, nv + N, 1
end

cnt = MaxFlow.new(g).solve(s, t)
ans = vertexes.size * 2 - cnt
pp ans
pp cnt
pp vertexes.size

pp! edges