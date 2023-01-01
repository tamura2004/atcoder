# dp[i番目の足場] := コストの最小値
# dp[0] <- 0, other: inf
# chmin dp[i+1], dp[i] + (h[i+1] - h[i]).abs
# chmin dp[i+2], dp[i] + (h[i+2] - h[i]).abs
# dp[-1]が答え

n = gets.to_s.to_i
h = gets.to_s.split.map(&.to_i64)
inf = Int64::MAX//4
dp = make_array(inf, n)
dp[0] = 0_i64

n.times do |i|
  (1..2).each do |di|
    ii = i + di
    next if n <= ii
    chmin dp[ii], dp[i] + (h[ii] - h[i]).abs
  end
end

pp dp[-1]
