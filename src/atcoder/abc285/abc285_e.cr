# 円環問題とみなす、一か所固定が定番
# 最初の日を休日に固定する
# dp[i日目まで決めた][j日前が休み] := 収益の最大値
# 休む
# dp[i+1][0] = dp[i][j] + cost[j], j=0..i

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
cost = [0_i64] of Int64
a.each do |v|
  cost << cost[-1] + v
  cost << cost[-1] + v
end

dp = make_array(0_i64, n+1, n+1)
n.times do |i|
  n.times do |j|
    next if i < j
    [true, false].each do |rest|
      if rest
        chmax dp[i+1][0], dp[i][j] + cost[j]
      else
        chmax dp[i+1][j+1], dp[i][j]
      end
    end
  end
end

pp dp[-1].max
