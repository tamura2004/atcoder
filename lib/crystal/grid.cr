class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
  alias Pair = Tuple(Int32,Int32)

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

  def each(i)
    y,x = from_index(i)
    each(y,x) do |ny,nx|
      j = to_index(ny,nx)
      yield j
    end
  end

  def each
    h.times do |y|
      w.times do |x|
        yield y,x
      end
    end
  end

  def bfs(a : Array(Pair), &block)
    seen = Array.new(h) { Array.new(w, -1) }
    q = Deque(Pair).new
    a.each do |y,x|
      seen[y][x] = 0
      q << {y, x}
    end

    bfs(q, seen, block)
  end

  def bfs(iy : Int32, ix : Int32, &block)
    seen = Array.new(h) { Array.new(w, -1) }
    seen[iy][ix] = 0
    q = Deque.new([{iy, ix}])

    bfs(q, seen, block)
  end

  def bfs(
    q : Deque(Pair),
    seen : Array(Array(Int32)),
    &block
  )
    while q.size > 0
      y, x = q.shift
      each(y, x) do |ny, nx|
        block.call ny, nx, q, seen
        q << {ny, nx}
      end
    end
    return seen  
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def outside?(i)
    i < 0 || h * w <= i
  end

  def wall?(y, x)
    g[y][x] == '#'
  end

  def wall?(i)
    y, x = from_index(i)
    wall?(y, x)
  end

  def from_index(i)
    { i // w, i % w }
  end

  def to_index(y, x)
    y * w + x
  end
end