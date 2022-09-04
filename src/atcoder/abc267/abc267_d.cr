# dp[i個目][j個選んだ] := 最大

INF = Int64::MAX//4

n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
dp = make_array(-INF, n+1, m+1)


n.times do |i|
  (0..m).each do |j|
    next if i < j
    
    # 選ばない
    chmax dp[i+1][j], dp[i][j]

    # 選ぶ
    next if j == m
    if j == 0
      chmax dp[i+1][j+1], a[i] * (j + 1)
    else
      chmax dp[i+1][j+1], dp[i][j] + a[i] * (j + 1)
    end
  end
end

pp dp[-1][-1]