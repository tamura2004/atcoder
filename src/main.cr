require "crystal/modint9"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
wsum = a.sum

if wsum.odd?
  puts 0
  exit
end

wsum //= 2

dp = make_array(0.to_m, n+1, wsum+1, n+1)
dp[0][0][0] = 1.to_m

n.times do |i|
  (0..n).each do |j|
    (0..wsum).each do |w|
      next if dp[i][w][j] == 0.to_m
      dp[i+1][w][j] += dp[i][w][j]

      ww = w + a[i]
      jj = j + 1

      next if ww > wsum
      next if jj > n

      dp[i+1][ww][jj] += dp[i][w][j]
    end
  end
end

ans = 0.to_m
(0..n).each do |j|
  ans += dp[-1][-1][j] * j.f * (n-j).f
end
pp ans

