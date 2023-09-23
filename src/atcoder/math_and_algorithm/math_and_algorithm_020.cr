# dp[i枚選んだ][合計がj] := 通り数
# dp[0][0] = 1, 他は0で初期化

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dp = make_array(0_i64, 6, 1001)
dp[0][0] = 1_i64

a.each do |v|
  (1..5).reverse_each do |i|
    (0..1000).each do |j|
      break unless v + j <= 1000
      dp[i][v + j] += dp[i - 1][j]
    end
  end
end

pp dp[-1][-1]
