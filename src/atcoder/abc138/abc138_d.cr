require "crystal/graph"

# 木dpする
n, q = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)

(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

dp = make_array(0_i64, n)

q.times do
  v, x = gets.to_s.split.map(&.to_i64)
  v = v.pred
  dp[v] += x
end

# dfsでもやっておく

dfs = uninitialized Int32, Int32 -> Nil
dfs = ->(v : Int32, pv : Int32) do
  g.each(v) do |nv|
    next if nv == pv
    dp[nv] += dp[v]
    dfs.call(nv, v)
  end
end
dfs.call(0, -1)

puts dp.join(" ")