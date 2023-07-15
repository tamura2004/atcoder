n = gets.to_s.to_i64
a = gets.to_s.chars.map(&.to_i)

dp = make_array(0_i64, n, 2)

n.times do |i|
  if i.zero?
    if a[i] == 0
      dp[i][0] += 1
    else
      dp[i][1] += 1
    end
  else
    if a[i] == 0
      dp[i][1] += i
      dp[i][0] += 1
    else
      dp[i][1] += 1
      dp[i][0] += dp[i - 1][1]
      dp[i][1] += dp[i - 1][0]
    end
  end
end
pp dp.map(&.last).sum
