# dp
require "crystal/indexable"
h, w = gets.to_s.split.map(&.to_i64)
r = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)

a = Array.new(h) do
  gets.to_s.chars.map(&.to_i)
end

dp = make_array(1e10.to_i64, h, w, 2, 2)
dp[0][0][0][0] = 0_i64
dp[0][0][1][0] = c[0]
dp[0][0][0][1] = r[0]
dp[0][0][1][1] = c[0] + r[0]

h.times do |y|
  w.times do |x|
    2.times do |tate|
      2.times do |yoko|
        # 下への移動
        if y + 1 < h
          if a[y+1][x] ^ a[y][x] ^ yoko == 0
            chmin dp[y+1][x][tate][0], dp[y][x][tate][yoko]
          end
          
          if a[y+1][x] ^ a[y][x] ^ 1 ^ yoko == 0
            chmin dp[y+1][x][tate][1],dp[y][x][tate][yoko] + r[y+1]
          end
        end
        # 右への移動
        if x + 1 < w
          if a[y][x+1] ^ a[y][x] ^ tate == 0
            chmin dp[y][x+1][0][yoko], dp[y][x][tate][yoko]
          end
          
          
          if a[y][x+1] ^ a[y][x] ^ 1 ^ tate == 0
            chmin dp[y][x+1][1][yoko],dp[y][x][tate][yoko] + c[x+1]
          end
        end
      end
    end
  end
end

pp dp[-1][-1].flatten.min
