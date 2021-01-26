class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  getter h : Int32
  getter w : Int32
  getter g : Array(String)
  getter seen : Array(Array(Int32))

  def initialize(@h, @w, @g)
    @seen = Array.new(h){ Array.new(w,-1) }
  end

  def self.read
    h, w = gets.to_s.split.map { |v| v.to_i }
    g = Array.new(h) { gets.to_s.chomp }
    new(h, w, g)
  end

  def each(y, x)
    DIR[0,4].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      yield ny, nx
    end
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def solve
    sy = sx = gy = gx = 0
    h.times do |y|
      w.times do |x|
        case g[y][x]
        when 'S'
          sy = y
          sx = x
        when 'G'
          gy = y
          gx = x
        end
      end
    end

    q = [{sy,sx}]
    seen[sy][sx] = 0

    while q.size > 0
      y,x = q.shift
      if gy == y && gx == x
        return seen[gy][gx]
      end

      each(y,x) do |ny,nx|
        next if g[ny][nx] == '#'
        next if seen[ny][nx] != -1
        seen[ny][nx] = seen[y][x] + 1
        q << ({ny,nx})
      end
    end
    return -1
  end
end

puts Grid.read.solve