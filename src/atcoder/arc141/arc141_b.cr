require "crystal/modint9"
n, m = gets.to_s.split.map(&.to_u64)

quit 0 if n > 60

dp = make_array(0.to_m, 61, 61)

cnt = m
(1..60).each do |i|
  j = 1_u64 << (i - 1)
  if j < cnt
    dp[0][i] = j.to_m
    cnt -= j
  else
    dp[0][i] = cnt.to_m
    break
  end
end

(1...n).each do |i|
  (1..60).each do |j|
    dp[i][j] = dp[i - 1][...j].sum * dp[0][j]
  end
end
pp dp[n - 1].sum
