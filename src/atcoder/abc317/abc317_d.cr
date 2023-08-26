# dp[i区まで][j議席] := 最低何人

INF = Int64::MAX // 4

n = gets.to_s.to_i64
xyz = Array.new(n) do
  x, y, z = gets.to_s.split.map(&.to_i64)
  {x, y, z}
end

z_sum = xyz.sum(&.[2])

dp = make_array(INF, n + 1, z_sum + 1)
dp[0][0] = 0_i64

n.times do |i|
  x, y, z = xyz[i]
  k = Math.max(divceil(y - x, 2), 0)
  z_sum.times do |j|
    chmin dp[i + 1][j], dp[i][j]
    next if z_sum < j + z
    chmin dp[i + 1][j + z], dp[i][j] + k
  end
end

pp dp[-1][divceil(z_sum, 2)..].min
