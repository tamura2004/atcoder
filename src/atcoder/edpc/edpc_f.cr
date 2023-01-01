# dp[i文字目:s][j文字目:t] := 最長のLCSの長さ
# dp <- 0
# | s[i][j] == t[i][j]
#   dp[i+1][j+1] <- dp[i][j] + 1
# | s[i][j] != t[i][j]
#   dp[i+1][j+1] <- max dp[i+1][j], dp[i][j+1]
# 復元
# dpテーブルの右下から、左上に向かう、コーナーなら文字採用

s = gets.to_s
t = gets.to_s
dp = make_array(0_i64, s.size.succ, t.size.succ)
s.size.times do |i|
  t.size.times do |j|
    if s[i] == t[j]
      chmax dp[i+1][j+1], dp[i][j] + 1
    else
      chmax dp[i+1][j+1], Math.max(dp[i+1][j], dp[i][j+1])
    end
  end
end

i = s.size
j = t.size
ans = [] of Char
while 0 < i && 0 < j
  if dp[i][j] == dp[i-1][j]
    i -= 1
  elsif dp[i][j] == dp[i][j-1]
    j -= 1
  else
    ans << s[i-1]
    i -= 1
    j -= 1
  end
end

puts ans.reverse.join