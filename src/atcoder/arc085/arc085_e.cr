require "crystal/flow_graph/dinic"
include FlowGraph

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
max_earned_money = a.select(&.> 0).sum

root = 0
goal = n + 1
g = Graph(Int64).new(n + 2)

a.each_with_index do |cost, i|
  v = i + 1
  if cost > 0
    g.add root, v, cost
  else
    g.add v, goal, -cost
  end

  (v*2).step(by: v, to: n) do |nv|
    g.add nv, v, Int64::MAX
  end
end

min_lose_money = Dinic(Int64).new(g).solve
ans = max_earned_money - min_lose_money
pp ans
