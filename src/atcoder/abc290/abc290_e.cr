n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

tot = 0_i64
(2i64..n).each do |i|
  tot += (i // 2) * (n - i + 1)
end

ans = 0_i64
dp = Array.new(n+1) { [] of Int64 }
n.times do |i|
  dp[a[i]].each do |j|
    r = Math.min(j, n - i - 1)
    tot -= (r + 1)
  end
  dp[a[i]] << i
end

pp tot
