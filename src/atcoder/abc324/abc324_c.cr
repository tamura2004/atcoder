def query(s, t)
  dp = make_array(0_i64, s.size + 1, t.size + 1)

  (1..s.size).each do |i|
    dp[i][0] = i
  end

  (1..t.size).each do |j|
    dp[0][j] = j
  end

  (1..s.size).each do |i|
    (1..t.size).each do |j|
      if s[i - 1] == t[j - 1]
        dp[i][j] = Math.min(dp[i - 1][j - 1], Math.min(dp[i - 1][j], dp[i][j - 1]) + 1)
      else
        dp[i][j] = Math.min(dp[i - 1][j - 1] + 1, Math.min(dp[i - 1][j], dp[i][j - 1]) + 1)
      end
    end
  end

  dp[-1][-1]
end

n, t = gets.to_s.split
n = n.to_i

ans = [] of Int32

n.times do |i|
  tt = gets.to_s
  next if (t.size - tt.size).abs > 1
  if query(t, tt) <= 1
    ans << i + 1
  end
end

puts ans.size
puts ans.join(" ")
