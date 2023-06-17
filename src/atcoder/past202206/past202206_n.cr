require "crystal/flow_graph/dinic"

h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }

g = Graph.new(h*w*2)

h.times do |y|
  w.times do |x|
    g.add y * w + x, y * w + x + h * w, a[y][x]
  end
end

h.times do |y|
  w.times do |x|
    [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next unless 0 <= nx < w && 0 <= ny < h
      g.add y * w + x + h * w, ny * w + nx, Int64::MAX
    end
  end
end

ans = Dinic.new(g).solve(h*w, h*w - 1)

pp ans

seen = Array.new(h*w*2, false)
seen[h*w] = true
q = Deque.new([h*w])
while q.size > 0
  v = q.shift
  g[v].each do |edge|
    next if seen[edge.v]
    next if edge.cap == 0
    seen[edge.v] = true
    q << edge.v.to_i64
  end
end

grid = Array.new(h) { Array.new(w, '.') }
h.times do |y|
  w.times do |x|
    next if y == 0 && x == 0
    next if y == h - 1 && x == w - 1
    if seen[y*w + x] != seen[y*w + x + h*w]
      grid[y][x] = '#'
    end
  end
end

puts grid.map(&.join).join("\n")
