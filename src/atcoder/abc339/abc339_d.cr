require "crystal/grid"

n = gets.to_s.to_i
g = Grid.read(n)

sx = sy = gx = gy = -1

n.times do |y|
  n.times do |x|
    if g[y, x] == 'P'
      if sx == -1
        sy = y
        sx = x
      else
        gx = x
        gy = y
      end
    end
  end
end

q = Deque.new([{sy,sx,gy,gx}])
seen = Hash(Tuple(Int32,Int32,Int32,Int32), Int32).new(-1)
seen[{sy, sx, gy, gx}] = 0

while q.size > 0
  ay, ax, by, bx = q.shift
  if ay == by && ax == bx
    puts seen[{ay,ax,by,bx}]
    exit
  end

  Grid::DIR[...4].each do |vy, vx|
    nay = ay + vy
    nax = ax + vx
    if g.outside?(nay, nax) || g[nay, nax] == '#'
      nay = ay
      nax = ax
    end
    nby = by + vy
    nbx = bx + vx
    if g.outside?(nby, nbx) || g[nby, nbx] == '#'
      nby = by
      nbx = bx
    end
    next if seen[{nay,nax,nby,nbx}] != -1
    seen[{nay,nax,nby,nbx}] = seen[{ay,ax,by,bx}] + 1
    q << {nay,nax,nby,nbx}
  end
end

puts -1



