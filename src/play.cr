require "crystal/cht"

# dp[i] := ゴミiを拾うときの最小値(1-indexed)
# dp[i] = Min j <= i, dp[j-1] + (x[j] - a[i])^2 + y[j]^2
# dp[i] = a[i]^2 + Min j <= i, Line.new(-2x[j], dp[j-1] + x[j]^2 + y[j]^2)[a[i]]

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
x = gets.to_s.split.map(&.to_i64)
y = gets.to_s.split.map(&.to_i64)

dp = Array.new(n+1, 0_i64)
cht = CHT.new

(0...n).each do |i|
  cht << Line.new(-2_i64 * x[i], dp[i] + x[i] ** 2 + y[i] ** 2)
  dp[i+1] = a[i] ** 2 + cht.min(a[i])
end

pp dp[-1]
