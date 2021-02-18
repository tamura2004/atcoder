macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

n = gets.to_s.to_i
s = gets.to_s
t = gets.to_s

dp = Array.new(n) { Array.new(n, 0_i64) }
n.times { |i| dp[i][i] = 0_i64 }
(n - 1).times { |i| dp[i][i + 1] = 0_i64 }
(n - 2).times { |i| dp[i][i + 2] = s[i, 3] == t ? 1_i64 : 0_i64 }

4.upto(n) do |w|
  n.times do |i|
    next if i + w >= n
    j = i + w
    i.upto(j) do |k|
      chmax dp[i][j], dp[i][k] + dp[k][j]
    end
    flag =  w == 8 &&
      dp[i+1,3] == t &&
      dp[i+5,3] == t &&
      dp[i] == t[0] &&
      dp[i+4] == t[1] &&
      dp[i+8] == t[2]
    if flag
      chmax dp[i][j], 3_i64
    end
  end
end

pp dp