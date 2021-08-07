require "crystal/grid"

class Grid
  def each_with_dir(y, x)
    (0..3).each do |dir|
      dy, dx = DIR[dir]
      ny = y + dy
      nx = x + dx
      next if outside?(ny,nx)
      next if wall?(ny,nx)
      yield ny,nx,dir
    end
  end
end

h, w = gets.to_s.split.map(&.to_i)
sy, sx = gets.to_s.split.map(&.to_i.- 1)
gy, gx = gets.to_s.split.map(&.to_i.- 1)

g = Grid.new(h, w, (1..h).map { gets.to_s })

seen = (1..4).map { (1..h).map { [false] * w } }
4.times do |i|
  seen[i][sy][sx] = true
end

q = Deque.new(
  (0..3).map do |i|
    { 0, i, sy, sx }
  end
)

while q.size > 0
  cost, dir, y, x = q.shift
  # pp! [cost,dir,y,x]
  if y == gy && x == gx
    puts cost
    exit
  end
  seen[dir][y][x] = true

  g.each_with_dir(y,x) do |ny,nx,ndir|
    next if seen[ndir][ny][nx]

    if dir == ndir
      q.unshift({cost, ndir, ny, nx})
    else
      q << {cost + 1, ndir, ny, nx}
    end
  end
end
