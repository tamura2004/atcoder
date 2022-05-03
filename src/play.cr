require "crystal/flow_graph/dinic"
include FlowGraph

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = a.select(&.> 0).sum

g = Graph(Int64).new(n + 2)
root = n
goal = n + 1

a.each_with_index do |cost, v|
  if cost > 0
    g.add v, goal, cost
  else
    g.add root, v, -cost
  end
end

(1..n).each do |i|
  i.step(by: i, to: n) do |j|
    g.add i - 1, j - 1, Int64::MAX
  end
end

ans -= Dinic(Int64).new(g).solve(root, goal)
pp ans
