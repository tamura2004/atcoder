require "crystal/modint9"
require "crystal/grid"

h, w = gets.to_s.split.map(&.to_i64)
grid = Grid.read(h)
seen = Array.new(h) { Array.new(w, nil.as(Int32?)) }

cnt = 0
red = 0

h.times do |y|
  w.times do |x|
    next if seen[y][x]
    if grid[y][x] == '.'
      red += 1
      next
    end

    cnt += 1
    seen[y][x] = cnt
    q = Deque.new([{y, x}])

    while q.size > 0
      cy, cx = q.shift
      grid.each_with_char(cy, cx) do |ny, nx, chr|
        next if chr == '.'
        next if seen[ny][nx]
        seen[ny][nx] = cnt
        q << ({ny, nx})
      end
    end
  end
end

tot = 0.to_m
h.times do |y|
  w.times do |x|
    next if grid[y][x] == '#'

    sub = Set(Int32).new
    grid.each(y, x) do |ny, nx|
      s = seen[ny][nx]
      next if s.nil?
      sub << s
    end

    case sub.size
    when 0
      tot += cnt + 1
    when 1
      tot += cnt
    else
      tot += cnt - sub.size + 1
    end
  end
end

pp tot // red