require "crystal/weighted_flow_graph/min_cost_flow"
require "crystal/prime"
include WeightedFlowGraph

n = gets.to_s.to_i64
ab = Array.new(n) do |v|
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b, v}
end

even = ab.select(&.first.even?)
odd = ab.select(&.first.odd?)

root = n
goal = n + 1
g = Graph.new(n+2)

odd.each do |a, b, v|
  cost = a == 1 ? 1_i64 : 0_i64 # 1を利用するコスト
  g.add root, v, b, cost
end

even.each do |a, b, v|
  g.add v, goal, b, 0
end

odd.each do |ar, br, v|
  even.each do |al, bl, nv|
    if (al + ar).is_prime?
      g.add v, nv, Math.min(bl, br), 0_i64
    end
  end
end

ans, cost = MinCostFlow.new(g).solve(root, goal)

odd.each do |a,b,v|
  if a == 1
    ans += b - cost >> 1
  end
end

pp ans
