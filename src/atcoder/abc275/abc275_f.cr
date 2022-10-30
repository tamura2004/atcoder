# dp
# dp[iまで決めた][j直前を選んだ0,1][k合計：limit M] := 分割回数
# 分割が増えるのは、直前選ぶ→今回選ばないのみ
# （選ばない→選ぶでカウントしない）
# そのため、初期値は選ばない

INF = Int64::MAX//4

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
dp = make_array(INF, n + 1, 2, m + 1)
dp[0][0][0] = 1_i64
dp[0][1][0] = 0_i64

n.times do |i|
  ii = i + 1
  2.times do |j|
    2.times do |jj|
      (0..m).each do |k|
        kk = k + (jj == 1 ? a[i] : 0)
        next if m < kk

        chmin dp[ii][jj][kk], dp[i][j][k] + (j == 1 && jj == 0 ? 1 : 0)
      end
    end
  end
end

(1..m).each do |x|
  ans = Math.min dp[-1][0][x], dp[-1][1][x]
  puts ans == INF ? -1 : ans
end
