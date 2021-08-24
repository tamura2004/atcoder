h, w = gets.to_s.split.map(&.to_i)
g = (1..h).map do
  gets.to_s.chars.map { |c| c == '.' ? 0_i64 : 1_i64 }
end

# h = 400
# w = 300
# g = (1..h).map{ |y| (1..w).map { |x| (x.even? ^ y.even?).to_unsafe.to_i64 }}

# 連結成分の個数
conn = [] of Tuple(Int64, Int64)
seen = (1..h).map { [false] * w }

h.times do |y|
  w.times do |x|
    next if seen[y][x]
    seen[y][x] = true

    white = 1_i64 - g[y][x]
    black = g[y][x]

    q = Deque.new([{y, x}])
    while q.size > 0
      y, x = q.shift

      [{-1, 0}, {1, 0}, {0, 1}, {0, -1}].each do |dy, dx|
        ny = y + dy
        nx = x + dx
        next if ny < 0 || h <= ny
        next if nx < 0 || w <= nx
        next if g[y][x] == g[ny][nx]

        next if seen[ny][nx]
        seen[ny][nx] = true

        white += 1 - g[ny][nx]
        black += g[ny][nx]
        q << {ny, nx}
      end
    end

    conn << {white, black}
  end
end

ans = 0_i64
conn.each do |white, black|
  ans += white * black
end

pp ans
# pp conn