# bitDP
# dp[i番の男性まで決めた][S決まった女性の集合] := 場合の数
# dp[i+1][S | j] += dp[i][S], jはSに含まれない
# dp[-1][-1]が答え

require "crystal/mod_int"
require "crystal/bit_set"

n = gets.to_s.to_i
a = Array.new(n) do
  BitSet.new gets.to_s.split.join.to_i(2)
end
dp = make_array(0.to_m, n + 1, 1 << n)
dp[0][0] = 1.to_m

n.times do |i|
  BitSet.each(n) do |s|
    next if s.size != i
    n.times do |j|
      next if j.in?(s)
      next unless j.in?(a[i])
      dp[i + 1][(s + j).to_i] += dp[i][s.to_i]
    end
  end
end

pp dp[-1][-1]
