# 二部グラフの最大マッチング＝最小費用流

require "crystal/weighted_flow_graph/min_cost_flow"
include WeightedFlowGraph

inf = 1e10.to_i64

p,q = gets.to_s.split.map(&.to_i64)
a = Array.new(p){gets.to_s}
osu = Array.new(p){gets.to_s.split.map(&.to_i64)}
mesu = Array.new(q){gets.to_s.split.map(&.to_i64)}

happy = -> (i : Int64, j : Int64) do
  osu[i][0] - osu[i][1] + mesu[j][0] - mesu[j][1]
end

g = Graph.new(2+p+q)
root = 0+p+q
goal = 1+p+q

g.add root, goal, Math.min(p,q), inf

p.times do |i|
  g.add root, i, 1, 0
end

q.times do |j|
  g.add j + p, goal, 1, 0
end

p.times do |i|
  q.times do |j|
    next if a[i][j] == '0'
    cnt = happy.call(i,j)
    next if cnt <= 0
    g.add i, j + p, 1, inf - cnt
  end
end

ans = osu.sum(&.last) + mesu.sum(&.last)
if cnt = MinCostFlow.new(g).solve(root,goal,Math.min(p,q))
  i, cost = cnt
  ans += inf * i - cost
end
pp ans
