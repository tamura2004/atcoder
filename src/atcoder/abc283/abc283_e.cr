# 行ごとにdpをする
# dp[i行目を決める][j自身の反転][k上の反転] := 最小値
# chmin dp[i+1][jj][j], dp[i][j][k] + jj

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i) + [9] }
a << [2, 4] * (w//2 + 1)
a << [2, 4] * (w//2 + 1)

INF = Int32::MAX//4
dp = make_array(INF, h+1, 2, 2)
dp[0][0][0] = 0
dp[0][0][1] = 0
dp[0][1][0] = 1
dp[0][1][1] = 1

(1..h).each do |y|
  2.times do |gr|
    2.times do |pa|
      2.times do |me|
        cnt = w.times.all? do |x|
          a[y-1][x] == a[y-1][x+1] ||
          a[y-1][x] == a[y-1][x-1] ||
          a[y-1][x] ^ pa == a[y-2][x] ^ gr ||
          a[y-1][x] ^ pa == a[y][x] ^ me
        end
        if cnt
          chmin dp[y][me][pa], dp[y-1][pa][gr] + me
        end
      end
    end
  end
end

ans = dp[-1].flatten.min
puts ans == INF ? -1 : ans

