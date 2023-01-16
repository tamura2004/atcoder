# dp[i頂点の連結グラフ][j種類の最遠点がある]
# 頂点をk個、同じ距離に追加するとき
# dp[i][k] += dp[i-k][j] * (2 ** j - 1) ** k * (2 ** ((k-1)*k//2)) * c(n-i+k-1,k)
# k < i - j

n, m = gets.to_s.split.map(&.to_i64)

# combination
c = Array.new(n) { Array.new(n, 0_i64) }
c[0][0] = 1_i64
n.times{|i|c[i][0] = 1_i64}
(1...n).each do |y|
  (1...n).each do |x|
    c[y][x] = (c[y-1][x-1] + c[y-1][x]) % m
  end
end

# pw2
pw2 = Array.new(n**2, 0_i64)
pw2[0] = 1_i64
(1...n**2).each do |i|
  pw2[i] = (pw2[i-1] * 2_i64) % m
end

# pw
# (2 ** j - 1) ** k % mod
# j, k <= n
pw = Array.new(n+1) { Array.new(n+1,0_i64)}
n.times do |j|
  pw[j][0] = 1_i64
  (1..n).each do |k|
    pw[j][k] = pw[j][k-1] * (pw2[j] - 1)
    pw[j][k] %= m
  end
end

dp = make_array(0_i64, n, n+1)
dp[1][1] = 1_i64

(2i64...n).each do |i|
  (1i64...i).each do |k|
    (1i64..i-k).each do |j|
      cnt = dp[i - k][j] * pw[j][k]
      cnt %= m
      cnt *= pw2[k * (k - 1) // 2]
      cnt %= m
      cnt *= c[n - i + k - 1][k]
      cnt %= m

      dp[i][k] += cnt
      dp[i][k] %= m
    end
  end
end

ans = 0_i64
(1..n).each do |j|
  cnt = dp[n - 1][j]
  ans += (pw2[j] - 1) * cnt
  ans %= m
end
pp ans


