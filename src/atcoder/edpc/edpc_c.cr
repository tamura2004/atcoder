# dp[i日目][j最後の活動] := 幸福の最大値
# dp <- 0
# dp[i+1][jj] <- dp[i+1][j] + a[i][jj] | j != jj
# dp[-1].maxが答え

n = gets.to_s.to_i64
a = (1..n).map{gets.to_s.split.map(&.to_i64)}
dp = make_array(0_i64, n+1, 3)

n.times do |i|
  3.times do |j|
    3.times do |jj|
      next if j == jj
      chmax dp[i+1][jj], dp[i][j] + a[i][jj]
    end
  end
end

pp dp[-1].max