# 辺i = par[vi] - viとする
# 根の辺の色はダミーとしてINFを入れる
# 上からdfsで更新
# 親の色を一つで集合Sを初期化
# 各子についてmexを割り当ててSに追加

n = gets.to_s.to_i
g = Graph.new(n)
(n+1).times do
  g.read
end

dp = Array.new(n, 0)

dfs = unsigned (Int32, Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32, color: Int32) do
  dp[v] = color

  s = Set.new([color])
  i = 1

  while i.in?(s)
    i += 1
  end

  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v, i)
    s << i

    while i.in?(s)
      i += 1
    end
  end
end
dfs.call(0, -1, 1e9.to_i)
pp dp