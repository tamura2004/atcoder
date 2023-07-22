# 2次元累積和で二分探索
require "crystal/cumulative_sum_2d"
require "crystal/matrix"
require "crystal/range"

# m = Matrix(Int32).new([
#   [1, 2, 3, 4, 5],
#   [2, 3, 4, 5, 6],
#   [3, 4, 5, 6, 7],
#   [4, 5, 6, 7, 8],
# ])
# cs = CS2D.new(m)
# pp cs[1.y + 1.x..2.y + 3.x]
# pp cs[1.y + 1.x...3.y + 4.x]
# pp cs[..1.y + 1.x]
# pp cs[2.y + 3.x..]

h, w, n = gets.to_s.split.map(&.to_i64)
g = Array.new(h){Array.new(w, 0_i64) }
n.times do
  y, x = gets.to_s.split.map(&.to_i64.pred)
  g[y][x] = 1_i64
end

m = Matrix(Int64).new(g)
cs = CS2D.new(m)
ans = 0_i64

h.times do |y|
  w.times do |x|
    next if g[y][x] == 1_i64
    d = Math.min w - 1 - x, h - 1 - y 
    cnt = (0..d).reverse_bsearch do |mid|
      cs[y.y+x.x..(y+mid).y+(x+mid).x] == 0_i64
    end.not_nil!
    ans += cnt + 1
  end
end

pp ans
