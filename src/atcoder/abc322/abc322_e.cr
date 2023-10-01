# dp[i番目][ハッシュキー：k個の組のペア] := 最小コスト
INF = Int64::MAX // 4

n, k, p = gets.to_s.split.map(&.to_i)
dp = Array.new(n + 1) do
  Hash(Array(Int32), Int64).new do |h, k|
    h[k] = INF
  end
end

plans = Array.new(n) do
  c, *costs = gets.to_s.split.map(&.to_i64)
  {c, costs}
end

init = Array.new(k, 0)
dp[0][init] = 0_i64

goal = Array.new(k, p)
n.times do |i|
  # 実行しない
  dp[i].each do |key, val|
    chmin dp[i + 1][key], val
  end

  # pp! dp
  # # 実行する
  dp[i].each do |key, val|
    cost, plan = plans[i]
    nkey = key.zip(plan).map(&.sum)
    nkey = nkey.map { |v| Math.min(v, p) }
    chmin dp[i + 1][nkey], val + cost
  end
end

ans = dp[-1][goal]
puts ans == INF ? -1 : ans
