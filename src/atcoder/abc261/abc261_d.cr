n, m = gets.to_s.split.map(&.to_i64)
x = gets.to_s.split.map(&.to_i64)

y = Array.new(n+1, 0_i64)
m.times do
  i, v = gets.to_s.split.map(&.to_i64)
  y[i] = v
end

dp = make_array(0_i64, n+1, n+1)
# (n+1).times{|i|dp[i][0] = 0_i64}

n.times do |i|
  ii = i + 1

  (0_i64..i).each do |j|
    jj = j + 1
    next if n < jj

    chmax dp[ii][jj], dp[i][j] + x[i] + y[jj]
    chmax dp[ii][0], dp[i][j]
  end
end

pp dp[-1].max

