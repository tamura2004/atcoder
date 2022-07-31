require "crystal/modint9"
require "crystal/prime"

# mod全探索
# dp

def solve(a, m)
  n = a.size
  dp = make_array(0.to_m, n + 1, m + 1, m)
  dp[0][0][0] = 1.to_m

  n.times do |i|
    ii = i + 1
    (0..m).each do |j|   # j個足した
      m.times do |k| # 余りがk
      # 足さない
        dp[ii][j][k] += dp[i][j][k]

        next if m < j + 1

        # 足す
        kk = (k + a[i]) % m
        dp[ii][j + 1][kk] += dp[i][j][k]
      end
    end
  end
  dp[-1][-1][0]
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = n.to_m # 1個選ぶ

(2..n).each do |m|
  ans += solve(a, m)
end

pp ans
