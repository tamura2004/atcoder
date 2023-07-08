require "crystal/graph"

n, m = gets.to_s.split.map(&.to_i64)
p = [-1] + gets.to_s.split.map(&.to_i)
g = Graph.new(p)
# gets.to_s.split.map(&.to_i.pred).zip(1..).each do |v, 

dp = Array.new(n, 0)
m.times do
  x, y = gets.to_s.split.map(&.to_i)
  x -= 1
  chmax dp[x], y+1
end

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  if pv != -1
    chmax dp[v], dp[pv] - 1
  end
  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v)
  end
end
dfs.call(0, -1)

ans = dp.count(&.> 0)
pp ans