require "crystal/indexable"
require "crystal/abc168/f/cow_graph"
include Abc168::F

INF = 1e18.to_i64 * 5

n, m = gets.to_s.split.map(&.to_i64)

tate = Array.new(n) do
  Tuple(Int64, Int64, Int64).from gets.to_s.split.map(&.to_i64)
end.sort_by(&.last)

yoko = Array.new(m) do
  Tuple(Int64, Int64, Int64).from gets.to_s.split.map(&.to_i64)
end.sort_by(&.first)

ys = yoko.map(&.first).uniq.sort
xs = tate.map(&.last).uniq.sort
h = ys.size + 1
w = xs.size + 1

# pp! xs
# pp! ys
# pp! w
# pp! h

# 領域の面積のグリッド
grid = Array.new(h) do
  Array(Int64?).new(xs.size + 1, nil)
end

(w - 2).times do |i|
  left = xs[i]
  right = xs[i + 1]
  width = right - left

  (h - 2).times do |j|
    bottom = ys[j]
    top = ys[j + 1]
    height = top - bottom

    grid[j + 1][i + 1] = width * height
  end
end

ys = [Int64::MIN] + ys + [Int64::MAX]
xs = [Int64::MIN] + xs + [Int64::MAX]

g = CowGraph.new(h, w)

# 連結グラフ
# g = Array.new(h) do |y|
#   Array.new(w) do |x|
#     if y.zero? || x.zero? || y == h-1 || x == w-1
#       0b0000 # 外周
#     else
#       0b1111 # 上下左右
#       # 0b11 # 左右
#     end
#   end
# end

# 縦線の通行止めを削除
tate.each do |a, b, c|
  ai = ys.count_less(a)
  bi = ys.count_less_or_equal(b) - 1
  ci = xs.upper_bound(c, eq: false)

  # pp! [a,b,c,ai,bi,ci]

  (ai...bi).each do |y|
    g.off(y, ci, DIR::Right)
    g.off(y, ci + 1, DIR::Left)
  end
end

# 横線の通行止めを削除
yoko.each do |a, b, c|
  ai = ys.upper_bound(a, eq: false)
  bi = xs.count_less(b)
  ci = xs.count_less_or_equal(c) - 1

  # pp! xs
  # pp! [a,b,c,ai,bi,ci]

  (bi...ci).each do |x|
    g.off(ai, x, DIR::Down)
    g.off(ai + 1, x, DIR::Up)
  end
end

# 訪問済
seen = Array.new(h) do
  Array.new(w, false)
end

sy = ys.upper_bound(0)
sx = xs.upper_bound(0)
# pp! [sy,sx]
seen[sy][sx] = true
# pp seen.reverse

q = Deque.new([{sy, sx}])
while q.size > 0
  y, x = q.shift
  g.each(y, x) do |ny, nx|
    next if ny < 0 || h <= ny || nx < 0 || w <= nx
    next if seen[ny][nx]
    seen[ny][nx] = true
    q << {ny, nx}
  end
  # puts seen.map(&.map{|v| v ? "*" : "."}.join).reverse.join("\n")
  # puts
end

# pp grid.reverse
# pp g
# puts seen.map(&.map{|v| v ? "*" : "."}.join).reverse.join("\n")

ans = 0_i64
h.times do |y|
  w.times do |x|
    next unless seen[y][x]
    quit "INF" if grid[y][x].nil?
    ans += grid[y][x].not_nil!
  end
end

pp ans
