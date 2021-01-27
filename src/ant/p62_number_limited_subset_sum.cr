n = gets.to_s.to_i64
k = gets.to_s.to_i64
a = gets.to_s.split.map { |v| v.to_i64 }
m = gets.to_s.split.map { |v| v.to_i64 }

# dp[j]
#   | jを作れない := -1
#   | jを作れる := 余る最大のi番目の個数
#
# dp[0] := 0
# dp[x != 0] := -1
#
# dp[j]
#   | dp[j] != 0 = m[i]
#   | j < a[i] || dp[j-a[i]] <= 0 := -1
#   | other := dp[j-a[i]] - 1

dp = Array.new(k+1, -1i64)
dp[0] = 0i64
n.times do |i|
  0.upto(k) do |j|
    case
    when dp[j] != -1
      dp[j] = m[i]
    when j < a[i] || dp[j - a[i]] <= 0
      dp[j] = -1
    else
      dp[j] = dp[j - a[i]] - 1
    end
  end
end
puts dp[-1] != -1 ? "Yes" : "No"
