require "crystal/modint9"

n, x = gets.to_s.split.map(&.to_i64)
t = gets.to_s.split.map(&.to_i64)
rev = 1.to_m // n

dp = Array.new(x + 1, 0.to_m)
dp[0] = rev

x.times do |j|
  n.times do |i|
    jj = j + t[i]
    next if x < jj
    dp[jj] += dp[j] * rev
  end
end

ans = dp.last(t[0]).sum
pp ans
