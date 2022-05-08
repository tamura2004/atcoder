require "crystal/weighted_flow_graph/min_cost_flow"
include WeightedFlowGraph

enum C
  Y
  U
  K
  I
end

n = gets.to_s.to_i
s = gets.to_s.chars.map do |c|
  case c
  when 'y' then C::Y
  when 'u' then C::U
  when 'k' then C::K
  when 'i' then C::I
  else          raise "bad"
  end
end
v = gets.to_s.split.map(&.to_i64)

g = Graph.new(n + 2)
root = n
goal = n + 1
INF = 1e5.to_i64
MAX = 1e9.to_i64

# 先頭のyにrootから辺を貼る
n.times do |i|
  if s[i].y?
    g.add root, i, INF, 0
    break
  end
end

# 次の出現位置を事前計算
nex = make_array(-1, n, 4)
nex[-1][s[-1].value] = n - 1
(0...n - 1).reverse_each do |i|
  4.times { |j| nex[i][j] = nex[i + 1][j] }
  nex[i][s[i].value] = i
end

# 隣接する同じ文字に辺を貼る
(0...n-1).each do |i|
  j = nex[i+1][s[i].value]
  next if j == -1
  g.add i, j, INF, 0
end

# y,u,kからu,k,iへ辺を貼る
(0...n-1).each do |i|
  j = s[i].value + 1
  next if j == 4
  if nex[i+1][j] != -1
    g.add i, nex[i+1][j], 1, MAX - v[i]
  end
end

# iからgoalへ辺を貼る
n.times do |i|
  next unless s[i].i?
  g.add i, goal, 1, MAX - v[i]
end

# g.debug
flow, cost = MinCostFlow.new(g).solve(root, goal, n)
# pp! [flow,cost]
ans = flow * MAX * 4 - cost
pp ans
