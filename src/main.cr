require "crystal/modint9"
# 部分和問題
# 数列aのixを必ず選ぶとして、合計k以下の組み合わせは？
def solve(a, ix, k)
  n = a.size
  dp = make_array(0.to_m, n+1, k+1)
  dp[0][a[ix]] = 1.to_m if a[ix] <= k

  n.times do |i|
    0.upto(k) do |j|
      dp[i+1][j] += dp[i][j]

      jj = j + a[i]
      next if jj > k || ix == i

      dp[i+1][jj] += dp[i][j]
    end
  end

  dp[-1].sum
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

dp = make_array(0.to_m, n+1)
dp[0] = 1.to_m
a.each_with_index do |v, i|
  dp[i+1] += dp[i]
  dp[i+1] += dp[i] if solve(b, i, v).to_i64 != 0
end

pp dp[-1]

