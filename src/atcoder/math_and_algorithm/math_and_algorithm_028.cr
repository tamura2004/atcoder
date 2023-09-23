INF = Int64::MAX//4

n = gets.to_s.to_i64
h = gets.to_s.split.map(&.to_i64)
dp = Array.new(n, INF)
dp[0] = 0_i64

(n - 1).times do |i|
  (1..2).each do |j|
    next unless i + j < n
    chmin dp[i + j], dp[i] + (h[i + j] - h[i]).abs
  end
end

pp dp[-1]
