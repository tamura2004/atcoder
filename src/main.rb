def count(s,a)
  n = s.size
  dp = Array.new(n+1){ Array.new(2){ Array.new(2){ 0 } } }

  # dp[index][未満フラグ][先頭が0 or a]
  dp[0][0][0] = 1

  s.chars.map(&:to_i).each_with_index do |v,i|
    dp[i+1][0][0] = dp[i][0]
    dp[i+1][0][1] = dp[i][0]
    
    dp[i+1][1] = dp[i][0] * v + dp[i][1] * 10
  end
  dp[n][0] + dp[n][1]
end

s = gets.chomp
puts count(s)
