# 磁石の隣接位置を特別扱い
# 0-1BFS

require "crystal/grid"
h, w = gets.to_s.split.map(&.to_i64)
s = Array.new(h){ gets.to_s.chars }

h.times do |y|
  w.times do |x|
    next if s[y][x] != '#'
    [{1, 0}, {-1, 0}, {0, 1}, {0, -1}].each do |vy, vx|
      ny = y + vy
      nx = x + vx
      next unless 0<=ny<h && 0<=nx<w
      next if s[ny][nx] == '#'
      s[ny][nx] = 'x'
    end
  end
end

blank = h * w
magne = 0_i64
neigh = 0_i64

h.times do |y|
  w.times do |x|
    case s[y][x]
    when '#'
      magne += 1
      blank -= 1
    when 'x'
      neigh += 1
      blank -= 1
    end
  end
end

quit 1 if blank.zero? 

g = Grid.new(s.map(&.join))

seen = Array.new(h) { Array.new(w, false) }
hist = [] of Tuple(Int64,Int64)
cnt = Array.new(h) { Array.new(w, 0_i64) }

bfs = ->(ry : Int64, rx : Int64) do
  q = Deque.new([{ry, rx}])
  seen[ry][rx] = true
  cnt[ry][rx] += 1
  while q.size > 0
    y, x = q.shift
    # pp! [ry, rx, y, x]
    g.each(y, x) do |(ny, nx)|
      next if g[ny][nx] == '#'
      next if seen[ny][nx]
      if g[ny][nx] == 'x'
        seen[ny][nx] = true
        hist << {ny, nx}
        cnt[ry][rx] += 1
      else
        seen[ny][nx] = true
        cnt[ry][rx] += 1
        q << {ny, nx}
      end
    end
  end
  while hist.size > 0
    y, x = hist.pop
    seen[y][x] = false
  end
end

h.times do |y|
  w.times do |x|
    next if g[y][x] == '#'
    next if g[y][x] == 'x'
    next if seen[y][x]
    bfs.call(y, x)
  end
end

pp cnt.map(&.max).max
