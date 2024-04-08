# スタート地点に薬がなければNo
# 薬と薬の距離を求める
# スタート地点からBFSをし all point
# エネルギー量でグラフ
# グラフでパス検索

require "crystal/grid"

class BFS
  getter h : Int64
  getter w : Int64
  getter g : Grid

  def initialize(@g, @h, @w)
  end

  def solve(sy, sx)
    dep = make_array(Int32::MAX, h, w)
    dep[sy][sx] = 0
    q = Deque.new([{sy, sx}])

    while q.size > 0
      y, x = q.shift
      g.each_with_char(y, x) do |ny, nx, c|
        next if c == '#'
        next if dep[ny][nx] != Int32::MAX
        q << {ny, nx}
        chmin dep[ny][nx], dep[y][x] + 1
      end
    end
    dep
  end
end

h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s }
g = Grid.new(a)

sy = sx = gy = gx = -1_i64
h.times do |y|
  w.times do |x|
    case g[{y.to_i32, x.to_i32}]
    when 'S'
      sy = y
      sx = x
    when 'T'
      gy = y
      gx = x
    end
  end
end

bfs = BFS.new(g, h, w)

n = gets.to_s.to_i64
potions = Array.new(n) do
  y, x, e = gets.to_s.split.map(&.to_i64)
  y -= 1
  x -= 1
  {y, x, e}
end

if potions.none?{|y,x,e|sy==y && sx == x}
  quit :No
end

n += 1
potions << {gy, gx, 0_i64}

graph = make_array(Int32::MAX//4, n, n)

n.times do |i|
  y, x, e = potions[i]
  dep = bfs.solve(y, x)
  n.times do |j|
    ny, nx, ne = potions[j]
    ndep = dep[ny][nx]
    next if ndep > e
    graph[i][j] = ndep
  end
end

n.times do |k|
  n.times do |i|
    n.times do |j|
      chmin graph[i][j], graph[i][k] + graph[k][j]
    end
  end
end

root = -1
potions.each_with_index do |(y,x,e),i|
  if sy == y && sx == x
    root = i
  end
end

puts graph[root][-1] == Int32::MAX//4 ? :No : :Yes
