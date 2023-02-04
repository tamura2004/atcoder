# dp[i頂点の連結グラフ][j種類の最遠点がある]
# 頂点をk個、同じ距離に追加するとき
# dp[i][k] += dp[i-k][j] * (2 ** j - 1) ** k * (2 ** ((k-1)*k//2)) * c(n-i+k-1,k)
# k < i - j

require "crystal/dynamic_mod_int"
require "crystal/recursive_sequence"

n, m = gets.to_s.split.map(&.to_i64)
m.to_mod

# combination
c = Array.new(n) { Array.new(n, 0.to_m) }
n.times { |i| c[i][0] = 1.to_m }
(1...n).each do |y|
  (1..y).each do |x|
    c[y][x] = c[y - 1][x - 1] + c[y - 1][x]
  end
end

# pw2
pw2 = RecursiveSequence.new(n, [1.to_m]) do |a|
  a[-1] * 2
end

# f = 2 ** (k * (k - 1) // 2)
f = RecursiveSequence.new(n, [1.to_m]) do |a|
  a[-1] * pw2[a.size - 1]
end

# g = (2 ** j - 1) ** k % mod
# j, k <= n
pw = Array.new(n + 1) do |j|
  RecursiveSequence.new(n+1,[1.to_m]) do |a|
    a[-1] * (pw2[j] - 1)
  end
end

dp = make_array(0.to_m, n, n + 1)
dp[1][1] = 1.to_m

(2i64...n).each do |i|
  (1i64...i).each do |k|
    (1i64..i - k).each do |j|
      dp[i][k] += dp[i - k][j] * pw[j][k] * f[k] * c[n - i + k - 1][k]
    end
  end
end

ans = 0.to_m
(1..n).each do |j|
  ans += (pw2[j] - 1) * dp[n - 1][j]
end
pp ans
