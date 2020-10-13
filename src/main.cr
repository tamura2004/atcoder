class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]

  getter h : Int32
  getter w : Int32
  getter c : Array(String)
  getter seen : Array(Array(Bool))
  getter q : Deque(Tuple(Int32,Int32))

  def initialize(@h, @w, @c)
    @seen = Array.new(h){ Array.new(w, false) }
    @q = Deque(Tuple(Int32,Int32)).new
  end

  def self.read
    h,w = gets.to_s.split.map { |v| v.to_i }
    c = Array.new(h){ gets.to_s.chomp }
    new(h,w,c)
  end

  def bfs
    gy,gx = find('g')
    while q.size > 0
      vy,vx = q.shift
      if vy == gy && vx == gx
        return true
      end
      each(vy,vx) do |ny,nx,is_wall|
        next if is_wall
        next if seen[ny][nx]
        seen[ny][nx] = true
        q << {ny,nx}
      end
    end
    return false
  end

  def break_wall
    tmp = Deque(Tuple(Int32,Int32)).new
    h.times do |y|
      w.times do |x|
        next unless seen[y][x]
        tmp << {y,x}
      end
    end
    while tmp.size > 0
      y,x = tmp.shift
      each(y,x) do |ny,nx,is_wall|
        next unless is_wall
        next if seen[ny][nx]
        seen[ny][nx] = true
        q << {ny,nx}
      end
    end
  end

  def solve
    sy,sx = find('s')
    q << {sy,sx}
    seen[sy][sx] = true

    3.times do
      return "YES" if bfs
      break_wall
    end
    return "NO"
  end
  
  def each(y, x)
    DIR.each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      yield ny, nx, wall?(ny, nx)
    end
  end

  def find(ch : Char)
    h.times do |y|
      w.times do |x|
        return {y,x} if c[y][x] == ch
      end
    end
    return {-1,-1}
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def wall?(y, x)
    c[y][x] == '#'
  end
end

g = Grid.read
puts g.solve

