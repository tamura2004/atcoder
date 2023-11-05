# dp[iまで決めた][j個取る] := 最大パフォーマンス
# dp[0][0] := 0
# dp[i+1][j+1] = (dp[i][j] + d[i]) * b[i] * 0.9 + p[i]) / b[i+1] - d[i+1] 

n = gets.to_s.to_i64
p = gets.to_s.split.map(&.to_i64)

b = [0.0f64]
n.times do
  b << b[-1] * 0.9 + 1.0
end

d = Array.new(n+1) do |i|
  i.zero? ? 0.0f64 : 1200.0f64 / Math.sqrt(i)
end

dp = make_array(-1e12.to_f64, n + 1, n + 1)

n.times do |i|
  (0..i).each do |j|
    chmax dp[i+1][j], dp[i][j]
    chmax dp[i+1][j+1], ((dp[i][j] + d[j]) * b[j] * 0.9 + p[i]) / b[j+1] - d[j+1]
  end
end

pp dp[-1].max