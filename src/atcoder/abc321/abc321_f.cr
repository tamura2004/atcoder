# dpの遷移をちゃんと立式する
# 戻せないと決めつけない、式変形で考察すれば糸口がつかめた
# インラインDPと同じ考え方で処理できる
# 追加：dp[i+1][j] = dp[i][j] + dp[i][j-k]
# 戻す：dp[i][j] = dp[i+1][j] - dp[i][j-k] : 下から更新する

require "crystal/modint9"

q, k = gets.to_s.split.map(&.to_i64)
dp = make_array(0.to_m, q + 1, k + 1)
dp[0][0] = 1.to_m

q.times do |i|
  cmd, x = gets.to_s.split
  x = x.to_i

  case cmd
  when "+"
    (0..k).each do |j|
      dp[i + 1][j] = dp[i][j]
      dp[i + 1][j] += dp[i][j - x] unless j - x < 0
    end
  when "-"
    (0..k).each do |j|
      dp[i + 1][j] = dp[i][j]
      dp[i + 1][j] -= dp[i + 1][j - x] unless j - x < 0
    end
  end
end

puts dp.map(&.last)[1..].join("\n")
