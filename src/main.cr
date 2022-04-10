require "crystal/grid"

alias V = Tuple(Int32, Int32)

h, w = gets.to_s.split.map(&.to_i)
s = Array.new(h) { gets.to_s }
g = Grid.new(h, w, s)
warp = Array.new(26) { [] of V }

sy = sx = gy = gx = -1
h.times do |y|
  w.times do |x|
    case g[y][x]
    when 'S'
      sy = y
      sx = x
    when 'G'
      gy = y
      gx = x
    when 'a'..'z'
      v = g[y][x].ord - 'a'.ord
      warp[v] << {y, x}
    end
  end
end

# 01-BFS
root = {sy, sx}
q = Deque(Tuple(Int32, Int32)).new([{sy, sx}])
INF = Int32::MAX
costs = make_array(INF, h, w)
costs[sy][sx] = 0

while q.size > 0
  y, x = q.shift

  if y == -1
  else
    g.each(y,x) do |ny,nx|
      next if costs[ny][nx] != INF
      costs[ny][nx] = costs[y][x] + 1
      q << {ny,nx}
    end
  end

  # pp! [y,x,cost]

  next if costs[{y, x}] < cost
  costs[{y, x}] = cost

  if y == gy && x == gx
    quit(cost)
  end

  if y == -1
    warp[x].each do |ny, nx|
      next if costs[{ny, nx}] < cost + 1
      q << {ny, nx, cost + 1}
    end
  else
    g.each(y, x) do |ny, nx|
      next if costs[{ny, nx}] < cost + 1
      q << {ny, nx, cost + 1}
    end

    if g[y][x].in?('a'..'z')
      v = g[y][x].ord - 'a'.ord
      next if costs[{-1, v}] < cost
      q.unshift({-1, v, cost})
    end
  end
end
