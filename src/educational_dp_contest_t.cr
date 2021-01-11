# https://atcoder.jp/contests/dp/tasks/dp_t

# dp[i][k] := p0~piまで決めたとき、i番目は残された数字のうち
# 小さいほうからk番目であるような組み合わせの数
# 遷移
# p_i > p_i+1のとき
# dp[i+1][m] = Σ k=m+1..* dp[i][k]
# p_i < p_i+1のとき
# dp[i+1][m] = Σ k=1..m-1.. dp[i][k]

n = gets.to_s.to_i
s = gets.to_s
dp = Array.new(n + 1) { Array.new(n, 0_i64) }

n.times do |i|
  n.times do |j|
    if s[i] == '>'
      dp[i + 1][j] = dp[i][j + 1..n - 1].sum
    else
      dp[i + 1][j] = dp[i][0..j - 1].sum
    end
  end
end

puts dp[-1][0]
