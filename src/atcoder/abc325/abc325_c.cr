DIR = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

h, w = gets.to_s.split.map(&.to_i64)
g = Array.new(h){ gets.to_s }
seen = Array.new(h) { Array.new(w, false) }
ans = 0_i64

h.times do |y|
  w.times do |x|
    next if g[y][x] == '.'
    next if seen[y][x]
    seen[y][x] = true

    ans += 1
    q = Deque.new([{y, x}])
    while q.size > 0
      cy, cx = q.shift

      DIR.each do |dy, dx|
        ny = cy + dy
        nx = cx + dx
        next unless 0 <= ny < h && 0 <= nx < w
        next if g[ny][nx] == '.'
        next if seen[ny][nx]
        seen[ny][nx] = true
        q << {ny, nx}
      end
    end
  end
end

pp ans





