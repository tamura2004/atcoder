# dp[i番目の品物まで決めた][j重さ以下] := 価値の最大値
n, maxw = gets.to_s.split.map(&.to_i64)
dp = make_array(0_i64, n+1, maxw+1)

n.times do |i|
  w, v = gets.to_s.split.map(&.to_i64)
  (0..maxw).each do |j|
    2.times do |use|
      jj = j + w * use
      break if maxw < jj
      chmax dp[i+1][jj], dp[i][j] + v * use
    end
  end
end

pp dp[-1].max

    