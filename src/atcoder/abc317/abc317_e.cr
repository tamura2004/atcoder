enum Muki
  Right
  Down
  Left
  Up
end

Kigou = {
  Muki::Up    => '^',
  Muki::Down  => 'v',
  Muki::Right => '>',
  Muki::Left  => '<',
}

h, w = gets.to_s.split.map(&.to_i64)
g = Array.new(h) { gets.to_s.chars }
seen = Array.new(h) { Array.new(w, false) }

gx = gy = sx = sy = -1
h.times do |y|
  w.times do |x|
    case g[y][x]
    when 'G'
      gx = x
      gy = y
      g[y][x] = '.'
    when 'S'
      sx = x
      sy = y
      g[y][x] = '.'
    when '#'
      seen[y][x] = true
    end
  end
end

4.times do |i|
  muki = Muki.new(i)
  kigou = Kigou[muki]

  h.times do |y|
    flag = false
    w.times do |x|
      if flag
        if g[y][x] == '.'
          seen[y][x] = true
        else
          flag = false
        end
      end

      if kigou == g[y][x]
        seen[y][x] = true
        flag = true
      end
    end
  end

  g = g.map(&.reverse).transpose
  seen = seen.map(&.reverse).transpose
  h, w = w, h
end

# pp g
# pp seen

# bfs
q = Deque.new([{sy, sx, 0}])
while q.size > 0
  y, x, ans = q.shift
  if y == gy && x == gx
    quit ans
  end

  [{1, 0}, {-1, 0}, {0, 1}, {0, -1}].each do |dy, dx|
    ny = y + dy
    nx = x + dx
    next if ny < 0 || h <= ny || nx < 0 || w <= nx
    next if seen[ny][nx]
    seen[ny][nx] = true
    q << {ny, nx, ans + 1}
  end
end

puts -1
