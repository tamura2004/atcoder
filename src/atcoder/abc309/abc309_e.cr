require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i64)
p = [-1] + gets.to_s.split.map(&.to_i)
g = Graph.new(p)

dp = Array.new(n, 0)
m.times do
  x, y = gets.to_s.split.map(&.to_i)
  x -= 1
  chmax dp[x], y+1
end

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  g.each(v) do |nv|
    next if nv == pv
    chmax dp[nv], dp[v] -1
    dfs.call(nv, v)
  end
end
dfs.call(0, -1)

ans = dp.count(&.> 0)
pp ans

pp g.to_plist