h,w = gets.to_s.split.map(&.to_i)
g = Array.new(h){ gets.to_s }

seen = Array.new(h){ Array.new(w){ false } }
DX = [0,1,0,-1]
DY = [1,0,-1,0]

inside = -> (y : Int32, x : Int32) do
  0 <= y && y < h && 0 <= x && x < w
end

bfs = -> (sy : Int32, sx : Int32) do
  q = Deque.new([{sy,sx}])
  black = 0_i64
  white = 0_i64

  while q.size > 0
    y, x = q.shift
    next if seen[y][x]
    seen[y][x] = true

    if g[y][x] == '#'
      black += 1
    else
      white += 1
    end

    4.times do |i|
      ny = y + DY[i]
      nx = x + DX[i]
      
      next unless inside.call(ny, nx)
      next if g[y][x] == g[ny][nx]
      q<< {ny, nx}
    end
  end

  black * white
end

ans = 0_i64
h.times do |y|
  w.times do |x|
    ans += bfs.call(y,x)
  end
end

pp ans