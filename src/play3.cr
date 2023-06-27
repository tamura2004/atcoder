n, m = gets.to_s.split.map(&.to_i64)
dp = make_array(0_i64, n+1, 11)
11.times do |j|
  (1..n).each do |i|
    dp[i][j] = (dp[i-1][j] * 10 + j) % m
  end
end

(1..n).reverse_each do |i|
  (1..9).reverse_each do |j|
    quit j.to_s * i if dp[i][j].zero?
  end
end

puts -1