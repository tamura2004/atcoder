n, d = gets.to_s.split.map(&.to_i64)
w = gets.to_s.split.map(&.to_i64)
INF = Int64::MAX//4
dp = make_array(INF, d, 1<<n)

d.times do |i|
  if i == 0
    (1<<n).times do |s|
      cnt = n.times.sum do |j|
        w[j] * s.bit(j)
      end ** 2
      dp[i][s] = cnt
    end
  else
    (1<<n).times do |s|
      t = s
      while t > 0
        t = (t - 1) & s
        chmin dp[i][s], dp[0][t] + dp[i-1][s ^ t]
      end
    end
  end
end

pp (dp[-1][-1] * d - w.sum ** 2) / d ** 2
