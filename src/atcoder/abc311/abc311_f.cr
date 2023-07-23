# dp!右下!
require "crystal/modint9"

h, w = gets.to_s.split.map(&.to_i64)
g = Array.new(h) { gets.to_s }
dp = make_array(0.to_m, h, w, 2)
dp[0][0][0] = 1.to_m if g[0][0] == '.'
dp[0][0][1] = 1.to_m

h.times do |y|
  w.times do |x|
    2.times do |i|   # 自分の色
      2.times do |j| # 下、右
        ny = y + 1
        nx = x + j
        next unless ny < h && nx < w
        if i == 1
          dp[ny][nx][1] += dp[y][x][1]
        else
          dp[ny][nx][0] += dp[y][x][0] if g[ny][nx] != '#'
          dp[ny][nx][1] += dp[y][x][0]
        end
      end
    end
  end
end

ans = 1.to_m
w.times do |x|
  ans *= dp[-1][x].sum
end

pp ans
