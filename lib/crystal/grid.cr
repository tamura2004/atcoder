class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  getter h : Int32
  getter w : Int32
  getter g : Array(String)

  def initialize(@h, @w, @g)
  end

  def self.read
    h, w = gets.to_s.split.map { |v| v.to_i }
    g = Array.new(h) { gets.to_s.chomp }
    new(h, w, g)
  end

  def each(y, x)
    DIR[0, 4].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(ny, nx)
      yield ny, nx
    end
  end

  def bfs(iy, ix)
    costs = Array.new(h) { Array.new(w, -1) }
    costs[iy][ix] = 0
    q = Deque.new([{iy, ix}])

    while q.size > 0
      y, x = q.shift
      each(y, x) do |ny, nx|
        next if costs[ny][nx] != -1
        costs[ny][nx] = costs[y][x] + 1
        q << {ny, nx}
      end
    end
    return costs
  end

  def solve
    h.times.max_of do |y|
      w.times.max_of do |x|
        next -1 if wall?(y, x)
        bfs(y, x).map(&.max).max
      end
    end
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def wall?(y, x)
    g[y][x] == '#'
  end
end