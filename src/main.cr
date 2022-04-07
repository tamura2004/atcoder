require "crystal/mod_int"
require "crystal/fact_table"

n, m, l = gets.to_s.split.map(&.to_i64)

# dp[i頂点利用][j辺利用] := 種類数
# 初期化：長さLのパスを含む、長さLのループを含む
# 遷移：
# 残りの頂点を１～利用
# ループか、パスか

quit(0) if m < l - 1 # パスも作れない

ans = 0.to_m

dp = make_array(0.to_m, n + 1, m + 1)
if l == 1
  dp[l][l - 1] = n.to_m
else
  dp[l][l - 1] = n.c(l) * l.f // 2
end

if l <= m && l != 1
  dp[l][l] = n.c(l) * (l - 1).f // 2
end

n.times do |i|
  m.times do |j|
    (1..n - i).each do |use|
      next if l < use
      2.times do |k|
        ii = i + use
        jj = j + use - k

        next if use == 1 && k == 0

        next if n < ii
        next if m < jj

        if k == 1
          if use == 1
            dp[ii][jj] += dp[i][j] * (n - i)
          else
            dp[ii][jj] += dp[i][j] * (n - i).c(use) * use.f * 2.inv
          end
        else
          dp[ii][jj] += dp[i][j] * (n - i).c(use) * (use - 1).f * 2.inv
        end
      end
    end
  end
end

pp dp[-1][-1]
