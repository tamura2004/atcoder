s = gets.to_s
t = gets.to_s
n = s.size
m = t.size

dp = make_array(0, n+1, m+1)

n.times do |i|
  m.times do |j|
    if s[i] == t[j]
      chmax dp[i+1][j+1], dp[i][j] + 1
    else
      chmax dp[i+1][j+1], dp[i+1][j]
      chmax dp[i+1][j+1], dp[i][j+1]
    end
  end
end

pp dp[-1][-1]