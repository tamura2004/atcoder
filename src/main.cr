require "crystal/modint9"

s = gets.to_s.chars
n = s.size
cnt = s.tally.values
m = cnt.size

dp = make_array(0.to_m, m + 1, n + 1)
dp[0][0] = 1.to_m

m.times do |i|
  n.times do |j|
    break if dp[i][j] == 0.to_m
    (0..cnt[i]).each do |k|
      dp[i + 1][j + k] += dp[i][j] * (j+k).c(k)
    end
  end
  # pp! dp[i+1]
end

ans = dp[-1][1..].sum
pp ans
