# dp[i番目まで決めた][j価値] := 重さの最小値
# dp <- inf
# dp[0][0] <- 0
# chmin dp[i+1][j+v], dp[i][j] + w
# dp[-1].zip(0..).select(&.[0].<= maxw).map(&.[1]).maxが答え

n, maxw = gets.to_s.split.map(&.to_i64)
inf = Int64::MAX//4
maxv = 1e5.to_i
dp = make_array(inf, n+1, maxv + 1)
dp[0][0] = 0_i64

n.times do |i|
  ii = i + 1
  w, v = gets.to_s.split.map(&.to_i64)
  (0..maxv).each do |j|
    2.times do |use|
      jj = j + v * use
      break if maxv < jj
      chmin dp[i+1][jj], dp[i][j] + w * use
    end
  end
end

pp dp[-1].zip(0..).select(&.[0].<= maxw).map(&.[1]).max
