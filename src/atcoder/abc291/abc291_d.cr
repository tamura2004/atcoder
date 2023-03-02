# dp
require "crystal/modint9"

n = gets.to_s.to_i64
a = Array.new(n){gets.to_s.split.map(&.to_i64)}

dp = make_array(0.to_m, n, 2)
dp[0][1] = 1.to_m
dp[0][0] = 1.to_m

(n-1).times do |i|
  2.times do |j|
    2.times do |jj|
      next if a[i+1][jj] == a[i][j]
      dp[i+1][jj] += dp[i][j]
    end
  end
end

pp dp[-1].sum
