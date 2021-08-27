require "crystal/digit_dp"
require "crystal/mod_int"

_n, k = gets.to_s.split
a = _n.chars.map(&.to_i(16))
n = a.size
num = k.to_i

dp = make_array(0.to_m, n+1, 1<<16, 2, 2)
dp[0][0][0][0] = 1.to_m

DigitDP.new(a, digit = 16).each_with_leading_zero do |i,j,k,d,jj,kk|
  (1<<16).times do |s|
    ss = jj == NONZ ? s | (1<<d) : s
    dp[i+1][ss][jj][kk] += dp[i][s][j][k]
  end
end

ans = 0.to_m
(1<<16).times do |s|
  next if s.popcount != num
  2.times do |k|
    ans += dp[-1][s][1][k]
  end
end

pp ans
