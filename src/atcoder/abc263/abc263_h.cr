require "crystal/multiset"

# 原点を中心とする円と直線の交点
# x^2 + y^2 = r^2
# ax + by + c = 0
#
# 交点が無い -> nil
# 交点がある -> 極座標の角度のペア（ラジアン）
def solve_intersection(a, b, c, r)
  a = a.to_f64
  b = b.to_f64
  c = c.to_f64
  r = r.to_f64

  a2 = a ** 2
  b2 = b ** 2
  c2 = c ** 2
  r2 = r ** 2

  d2 = (a2 + b2) * r2 - c2
  return nil if d2 < 0
  d = Math.sqrt(d2)

  x1 = (b * d - a * c) / (a2 + b2)
  y1 = -(a * d + b * c) / (a2 + b2)

  x2 = -(b * d + a * c) / (a2 + b2)
  y2 = (a * d - b * c) / (a2 + b2)

  {Math.atan2(y1, x1), Math.atan2(y2, x2)}
end

# EPS = 0.000000001

# 数直線上の範囲の集合がタプルの配列で与えられたとき
# 包含関係になく重なる区間数を求める
def solve_overlap(a)
  st = Multiset(Float64).new
  a.sort_by!(&.first)
  ans = 0_i64

  a.each do |lo, hi|
    ans += st.count_range(lo, hi)
    st << hi
  end

  ans
end

n, k = gets.to_s.split.map(&.to_i64)
abc = Array.new(n) do
  a,b,c = gets.to_s.split.map(&.to_i64)
  {a,b,c}
end

# 原点中心、半径rの円内に交点がk個以上ある
lo = 0.0
hi = 1e18
ans = (lo..hi).bsearch do |r|
  ranges = [] of Tuple(Float64,Float64)

  abc.each do |a,b,c|
    if range = solve_intersection(a,b,c,r)
      lo, hi = range
      lo, hi = hi, lo unless lo < hi
      ranges << {lo, hi}
    end
  end

  k <= solve_overlap(ranges)
end

pp ans

      