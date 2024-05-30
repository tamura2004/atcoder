require "crystal/cht"

n, c = gets.to_s.split.map(&.to_i64)
h = gets.to_s.split.map(&.to_i64)

# dp[i] := 足場iに到達するための最小コスト
# dp[i] = Min j < i, dp[j] + (h[j] - h[i])^2 + c
# dp[i] = Min j < i, dp[j] + h[j]^2 - 2 * h[j] * h[i] + h[i]^2 + c
# dp[i] = h[i]^2 + c + Min j < i, dp[j] + h[j]^2 - 2 * h[j] * h[i]
# dp[i] = h[i]^2 + c + Min j < i, Line(-2h[j], dp[j] + h[j]^2)[h[i]]

dp = Array.new(n, 0_i64)
cht = CHT.new
cht << Line.new(-2_i64 * h[0], h[0] ** 2)

(1...n).each do |i|
  dp[i] = cht.min(h[i]) + h[i] ** 2 + c
  cht << Line.new(-2_i64 * h[i], dp[i] + h[i] ** 2)
end

pp dp[-1]