alias Pair = Tuple(Int32, Int32)

class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]

  getter h : Int32
  getter w : Int32
  getter c : Array(String)
  getter warp : Array(Array(Int64))
  getter sy : Int32
  getter sx : Int32
  getter gy : Int32
  getter gx : Int32
  getter seen : Array(Array(Int32))

  def initialize(@h, @w, @c)
    @warp = Array.new(26) { [] of Int64 }
    @sy = @sx = @gy = @gx = 0
    h.times do |y|
      w.times do |x|
        case c[y][x]
        when 'S'
          @sy = y
          @sx = x
        when 'G'
          @gy = y
          @gx = x
        when 'a'..'z'
          i = c[y][x].ord - 'a'.ord
          @warp[i] << to_key(y, x)
        end
      end
    end
    @seen = Array.new(h) { Array.new(w, -1) }
  end

  def self.read
    h, w = gets.to_s.split.map { |v| v.to_i }
    c = Array.new(h) { gets.to_s.chomp }
    new(h, w, c)
  end

  def solve
    seen[sy][sx] = 0
    q = Deque(Pair).new
    q << {sy, sx}
    while q.size > 0
      y, x = q.shift
      if gy == y && gx == x
        return seen[y][x]
      end
      each(y, x) do |ny, nx|
        next if seen[ny][nx] != -1
        seen[ny][nx] = seen[y][x] + 1
        q << {ny, nx}
      end
    end
    return -1
  end

  def each(y, x)
    DIR.each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(ny, nx)
      yield ny, nx
    end

    i = c[y][x].ord - 'a'.ord
    if 0 <= i && i < 26
    # case c[y][x]
    # when 'a'..'z'
      if warp[i].size > 0
        key = to_key(y, x)
        warp[i].each do |nkey|
          next if key == nkey
          ny, nx = from_key(nkey)
          next if seen[ny][nx] != -1
          yield ny.to_i, nx.to_i
        end
      end
    end
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def wall?(y, x)
    c[y][x] == '#'
  end

  def to_key(y, x) : Int64
    y.to_i64 * w + x
  end

  def from_key(key)
    {key // w, key % w}
  end
end

pp Grid.read.solve
