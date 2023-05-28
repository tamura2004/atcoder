s = gets.to_s
n = s.size

dp = Array.new(n + 1) { Hash(String, Int64).new(0_i64) }
dp[0][""] = 0_i64

n.times do |i|
  (1..2).each do |j|
    token = s[i, j]
    dp[i].each do |k, v|
      next if token == k
      next if n < i + j
      chmax dp[i + j][token], v + 1
    end
  end
end

pp dp[-1].values.max
