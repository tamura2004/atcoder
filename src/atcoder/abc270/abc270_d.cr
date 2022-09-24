n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i)

# dp[i個取得済][jの手番、0:taka, 1:aoki] := 
# {自分の得点, 相手の得点}
dp = make_array(({0,0}), n + 1, 2)

# 配るDP
(0..n).reverse_each do |i|
  2.times do |j|
    a.each do |v|
      next if i - v < 0
      me, you = dp[i][j]
      chmax dp[i - v][1-j], ({you + v, me})
    end
  end
end

pp dp[0][0][0]

