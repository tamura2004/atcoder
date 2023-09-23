# インラインDPでやってみる
# dp[重さi] := 価値の最大

require "crystal/iota"

n, w_max = gets.to_s.split.map(&.to_i64)
dp = Array.new(w_max + 1, Int64::MIN)
dp[0] = 0_i64

n.times do
  w, v = gets.to_s.split.map(&.to_i64)

  (0_i64..w_max).reverse_each do |j|
    jj = j - w
    next if jj < 0
    chmax dp[j], dp[jj] + v
  end
end

pp dp.max
