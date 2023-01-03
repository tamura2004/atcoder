# bitDP
# dp[i番の男性まで決めた][S決まった女性の集合] := 場合の数
# dp[i+1][S | j] += dp[i][S], jはSに含まれない
# dp[-1][-1]が答え

require "crystal/mod_int"

n = gets.to_s.to_i
a = Array.new(n) { gets.to_s.split.map(&.to_i).join.to_i(2) }
dp = make_array(0.to_m, n+1, 1<<n)
dp[0][0] = 1.to_m

n.times do |i|
  (1<<n).times do |s|
    next if s.popcount != i
    n.times do |j|
      next if s.bit(j) == 1
      next if a[i].bit(j) == 0
      dp[i+1][s | (1<<j)] += dp[i][s]
    end
  end
end

pp dp[-1][-1]