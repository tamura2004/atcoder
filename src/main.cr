class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]

  getter h : Int32
  getter w : Int32
  getter c : Array(String)
  getter dp : Array(Array(Int32))

  def initialize(@h, @w, @c, @dp)
  end

  def self.read
    h, w = gets.to_s.split.map { |v| v.to_i }
    c = Array.new(h) { gets.to_s.chomp }
    dp = Array.new(h) { Array.new(w, -1) }
    new(h, w, c, dp)
  end

  def each(y, x)
    DIR.each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      # next if wall?(ny, nx)
      yield ny, nx
    end
  end

  def bfs
    q = [{0, 0}]
    dp[0][0] = 0

    while q.size > 0
      y, x = q.shift
      each(y, x) do |ny, nx|
        next if dp[ny][nx] != -1
        if wall?(ny, nx)
          dp[ny][nx] = dp[y][x] + 1
          q << ({ny, nx})
        else
          dp[ny][nx] = dp[y][x]
          q.unshift({ny, nx})
        end
      end
    end
  end

  def solve
    bfs
    puts dp.join("\n")
    dp.map(&.max).max
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def wall?(y, x)
    c[y][x] == '#'
  end
end

puts Grid.read.solve
