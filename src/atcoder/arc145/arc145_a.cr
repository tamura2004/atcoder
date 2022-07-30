# dp
n = gets.to_s.to_i64
s = gets.to_s

quit "No" if s == "AB"
quit "No" if s == "BA"
quit "Yes" if s == "AA"
quit "Yes" if s == "BB"

dp = make_array(0_i64, n//2 + 1, 5)
dp[0][0] = 1_i64

(n//2).times do |i|
  ii = i + 1

  3.times do |j|
    head = j == 1 ? 'B' : s[i]
    tail = j == 3 ? 'A' : s[n - 1 - i]

    if head == tail == 'A'
      dp[ii][0] |= dp[i][j]
      next if n.even? && ii == n // 2
      dp[ii][1] |= dp[i][j]
      dp[ii][2] |= dp[i][j]
    elsif head == tail == 'B'
      dp[ii][0] |= dp[i][j]
      next if n.even? && ii == n // 2
      dp[ii][3] |= dp[i][j]
      dp[ii][4] |= dp[i][j]
    elsif head == 'A' && tail == 'B'
    elsif head == 'B' && tail == 'A'
      next if n.even? && ii == n // 2
      dp[ii][1] |= dp[i][j]
      dp[ii][2] |= dp[i][j]
      dp[ii][3] |= dp[i][j]
      dp[ii][4] |= dp[i][j]
    end
  end
end

puts dp[-1].sum.zero? ? "No" : "Yes"