# dp!右下!
require "crystal/modint9"

# 範囲外参照でデフォルト値を返す
class Grid(T)
  getter h : Int32
  getter w : Int32
  getter g : Array(Array(T))
  getter init : T
  getter default : T

  def initialize(@h, @w, @init, @default)
    @g = Array.new(h) { Array.new(w, @init) }
  end

  def [](y, x)
    if 0 <= y < h && 0 <= x < w
      g[y][x]
    else
      default
    end
  end

  def []=(x,y,v)
    if 0 <= y < h && 0 <= x < w
      g[y][x] = v
    end
  end
end

h, w = gets.to_s.split.map(&.to_i64)
g = Grid(ModInt).new(h, w, 1.to_m, 1.to_m)
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
