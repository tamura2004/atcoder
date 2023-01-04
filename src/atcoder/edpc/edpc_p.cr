require "crystal/graph"
require "crystal/mod_int"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end
dp = make_array(1.to_m, n, 2)

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v)
    dp[v][0] *= dp[nv].sum
    dp[v][1] *= dp[nv][0]
  end
end
dfs.call(0, -1)
pp dp[0].sum