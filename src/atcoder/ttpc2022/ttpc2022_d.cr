require "crystal/graph"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
(n-1).times do
  g.read
end

ans = make_array(0, n, 2)

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  ch = [] of Int32
  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v)    
    ch << nv
  end

  dp = make_array(0, ch.size.succ, 2)
  ch.each_with_index do |nv, i|
    2.times do |j| # 元
      next if i == 0 && j == 1
      2.times do |k| # 先
        chmax dp[i+1][j^k], dp[i][j] + ans[nv][k]
      end
    end
  end

  ans[v][0] = a[v] + dp[-1][0]
  ans[v][1] = (1 - a[v]) + dp[-1][1]

end
dfs.call(0, -1)
pp ans[0].max