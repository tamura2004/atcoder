# 中央値は二分探索できる
# count_less_or_equal(x) := x以下の要素数
# query(x) := count_less_or_equal(x) >= |S| // 2

# 1 (4) 5 (6) (8) 9 19
# 1  1  2  2   2  3 4
# 1  3 (4) 5 (6) (8) 9 19
# 1  2  2  3  3   3  4  5

require "crystal/matrix"
require "crystal/cs2d"
require "crystal/range"

n, k = gets.to_s.split.map(&.to_i64)
nz = C.unit(n)
kz = C.unit(k)
m = Matrix.new(nz) do
  gets.to_s.split.map(&.to_i64)
end

lo = m.min
hi = m.max
ceil = k * k // 2 + 1

ans = (lo..hi).reverse_bsearch do |mid|
  cs = CS2D.new(m.map(&.>=(mid).to_unsafe))
  (nz - kz).succ.times.all? do |w|
    cs[w..w+kz.pred] >= ceil
  end
end

pp ans
