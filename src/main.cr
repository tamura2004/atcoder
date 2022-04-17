h,w,a,b = gets.to_s.split.map(&.to_i64)

tatami = [] of Int32

h.times do |y|
  (w-1).times do |x|
    tatami << (3 << (y * w + x))
  end
end

(h-1).times do |y|
  w.times do |x|
    tatami << ((1 + (1 << w)) << (y * w + x))
  end
end

m = tatami.size
dp = make_array(0_i64, m+1, 1<<(h*w))
dp[0][0] = 1_i64

m.times do |i|
  (1<<(h*w)).times do |s|
    dp[i+1][s] += dp[i][s]
    next if (tatami[i] & s) != 0
    dp[i+1][tatami[i] | s] += dp[i][s]
  end
end

ans = 0_i64
(1<<(h*w)).times do |s|
  next unless s.popcount == a*2
  ans += dp[-1][s]
end

pp ans
