# dp[i決め][jお腹] := おいしさの最大値

n = gets.to_s.to_i64
dp = make_array(Int64::MIN//4, n + 1, 2)
dp[0][0] = 0_i64

n.times do |i|
  x, y = gets.to_s.split.map(&.to_i64)
  chmax dp[i + 1][0], dp[i][0]
  chmax dp[i + 1][1], dp[i][1]

  case x
  when 0
    chmax dp[i + 1][0], dp[i][0] + y
    chmax dp[i + 1][0], dp[i][1] + y
  when 1
    chmax dp[i + 1][x], dp[i][0] + y
  end
end

pp dp[-1].max
pp dp