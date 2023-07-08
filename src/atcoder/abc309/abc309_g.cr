# 順列は挿入DP？
# dp[小さい順にi番目まで決めた][左からj番目で切ったとき][left_under][left_over][right_under][right_over] := 場合の数

require "crystal/modint9"
n, x = gets.to_s.split.map(&.to_i64)

dp = make_array(0.to_m, n + 1, n + 1, x + 1, x + 1, x + 1, x + 1)
dp[0][0][0][0][0][0] = 1.to_m

n.times do |i|
  (0..i).each do |j|
    x.succ.times do |lu|
      x.succ.times do |lo|
        x.succ.times do |ru|
          x.succ.times do |ro|
            rro = Math.min (j - i).abs, Math.max(ro - 1, 0)
            rru = Math.min (j - i).abs, Math.min(ru + 1, x)
            pp! [i,j,lu,lo,ru,ro,rru,rro]
            pp! dp[i][j][lu][lo][ru][ro]
            dp[i + 1][j][lu][lo][rru][rro] += dp[i][j][lu][lo][ru][ro]
          end
        end
      end
    end
  end
end

pp dp
