require "crystal/modint9"

s = gets.to_s
n = s.size
dp = make_array(0.to_m, n + 1, n + 1)
dp[0][0] = 1.to_m

n.times do |i|
  (0...n).each do |j|
    case s[i]
    when '('
      dp[i + 1][j + 1] += dp[i][j]
    when ')'
      dp[i + 1][j - 1] += dp[i][j]
    when '?'
      [-1, 1].each do |k|
        next if j + k < 0
        dp[i + 1][j + k] += dp[i][j]
      end
    end
  end
end

pp dp[-1][0]
