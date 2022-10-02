n,m,k = gets.to_s.split.map(&.to_i64)
edges = Array.new(m) do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v = v.to_i - 1
  nv = nv.to_i - 1
  {v, nv, cost}
end
e = gets.to_s.split.map(&.to_i.pred)

INF = 1e15.to_i64
dp = Array.new(n, INF)
dp[0] = 0_i64

e.each do |i|
  v, nv, cost = edges[i]
  if dp[v] != INF
    chmin dp[nv], dp[v] + cost
  end
end

puts dp[-1] == INF ? -1 : dp[-1]
