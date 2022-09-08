require "crystal/graph"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end

q, k = gets.to_s.split.map(&.to_i)
k = k.pred

dp = Array.new(n, 0_i64)

dfs = uninitialized (Int32, Int32, Int64) -> Nil
dfs = -> (v : Int32, pv : Int32, cost : Int64) do
  dp[v] = cost
  g.each_with_cost(v) do |nv, ncost|
    next if nv == pv
    dfs.call(nv, v, cost + ncost)
  end
end
dfs.call(k, -1, 0_i64)

q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  pp dp[v] + dp[nv]
end
