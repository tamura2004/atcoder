# dp[i決め][j個自分より前に買われている] := 費用の最小値
# 買う遷移、買わない遷移、xは必ず買う

require "crystal/sparse_table"

n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64).to_sp_min
x = gets.to_s.split.map(&.to_i.pred).to_set

dp = make_array(Int64::MAX//4, n + 1, n + 1)
dp[0][0] = 0_i64

n.times do |i|
  (0..i).each do |j|
    2.times do |buy|
      if buy.zero? && !i.in?(x)
        chmin dp[i+1][j], dp[i][j]
      else
        chmin dp[i+1][j+1], dp[i][j] + a[i] + c[i-j..i]
      end
    end
  end
end

pp dp[-1].min
