class Grid
  DIR = [{0,1},{1,0},{0,-1},{-1,0}]

  getter h : Int32
  getter w : Int32
  getter c : Array(String)

  def initialize(@h,@w,@c)
  end

  def each(y,x)
    DIR.each do |dy,dx|
      ny = y + dy
      nx = x + dx
      next if outside(ny,nx)
      next if c[ny][nx] == '#'
      yield ny, nx
    end
  end

  def outside(y,x)
    y < 0 || h <= y || x < 0 || w <= x
  end
end

h,w = gets.to_s.split.map { |v| v.to_i }
sy,sx = gets.to_s.split.map { |v| v.to_i - 1}
gy,gx = gets.to_s.split.map { |v| v.to_i - 1}
c = Array.new(h){ gets.to_s.chomp }
g = Grid.new(h,w,c)

seen = Array.new(h){ Array.new(w, -1) }
que = [{sy,sx}]
seen[sy][sx] = 0
while que.size > 0
  y,x = que.shift
  if y == gy && x == gx
    puts seen[gy][gx]
    exit
  end
  g.each(y,x) do |ny,nx|
    next if seen[ny][nx] != -1
    seen[ny][nx] = seen[y][x] + 1
    que << ({ny,nx})
  end
end
