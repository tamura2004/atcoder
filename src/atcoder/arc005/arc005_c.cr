# 01bfs
DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]

h, w = gets.to_s.split.map(&.to_i)
g = Array.new(h) { gets.to_s }

sx = sy = gx = gy = -1
h.times do |y|
  w.times do |x|
    if g[y][x] == 's'
      sy = y
      sx = x
    end

    if g[y][x] == 'g'
      gy = y
      gx = x
    end
  end
end

q = Deque.new([{sy,sx,0}])
seen = Array.new(h){Array.new(w,false)}
seen[sy][sx] = true

while q.size > 0
  y, x, cost = q.shift

  DIR.each do |dy,dx|
    ny = y + dy
    nx = x + dx
    next if ny < 0 || h <= ny || nx < 0 || w <= nx
    next if cost >= 3
    next if seen[ny][nx]
    seen[ny][nx] = true

    case g[ny][nx]
    when '.'
      q.unshift({ny,nx,cost})
    when '#'
      q << {ny,nx,cost + 1}
    when 'g'
      quit "YES"
    end
  end
end

puts "NO"

