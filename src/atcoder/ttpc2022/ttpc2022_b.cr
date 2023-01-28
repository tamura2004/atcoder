# dp[i決め][j円残る] := 最大何個買った
# 遷移
# j円残ってるなら
# 並べ替えて引く、正なら
# 並べ替えて保存
INF = Int64::MAX//4
n, x = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
dp = make_array(-INF, n+1, 10001)

permutations = Array.new(10001) do |i|
  i.to_s.chars.permutations.map(&.join.to_i64)
end

sort = Array.new(10001) do |i|
  i.to_s.chars.sort.reverse.join.to_i64
end

dp[0][sort[x]] = 0_i64

n.times do |i|
  (1..10000).each do |j|
    next if dp[i][j] == -1i64

    # 買わない
    chmax dp[i+1][j], dp[i][j]

    permutations[j].each do |yen|
      next if yen < a[i]
      chmax dp[i+1][sort[yen - a[i]]], dp[i][j] + 1
    end
  end
end

pp dp[-1].max