s = gets.to_s
t = gets.to_s

n = s.size
m = t.size

dp = Array.new(n+1){ Array.new(m+1, 0_u16) }
n.times do |i|
  m.times do |j|
    if s[i] == t[j]
      dp[i+1][j+1] = dp[i][j] + 1_u16
    end
  end
end

ans = dp.map(&.max).max
pp ans