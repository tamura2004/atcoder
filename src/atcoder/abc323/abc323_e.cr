require "crystal/modint9"

n, x = gets.to_s.split.map(&.to_i64)
t = gets.to_s.split.map(&.to_i64)

dp = Array.new(x + 1, 0.to_m)
dp[0] = 1.to_m // n

x.times do |j|
  n.times do |i|
    jj = j + t[i]
    next if x < jj
    dp[jj] += dp[j] // n
  end
end

ans = dp.last(t[0]).sum
pp ans
