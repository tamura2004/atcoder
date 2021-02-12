class PriorityQueue(T)
  getter f : T, T -> Bool
  getter a : Deque(T)

  forward_missing_to a

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
  end

  def <<(v : T)
    @a << v
    fixup(a.size - 1)
  end

  def pop : T
    ret = a[0]
    last = a.pop
    if a.size > 0
      a[0] = last
      fixdown
    end
    ret
  end

  def fixup(i : Int32)
    j = up(i)
    while i > 0 && comp j, i
      a.swap i, j
      i, j = j, up(j)
    end
  end

  def fixdown
    i = 0
    while lo(i) < a.size
      if hi(i) < a.size && comp lo(i), hi(i)
        j = hi(i)
      else
        j = lo(i)
      end
      break if comp j, i
      a.swap i, j
      i = j
    end
  end

  def comp(i, j)
    f.call a[i], a[j]
  end

  def lo(i)
    i * 2 + 1
  end

  def hi(i)
    i * 2 + 2
  end

  def up(i)
    (i - 1) // 2
  end
end

class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
  INF = Int32::MAX

  getter h : Int32
  getter w : Int32
  getter sy : Int32
  getter sx : Int32
  getter gy : Int32
  getter gx : Int32
  getter g : Array(String)
  getter costs : Array(Array(Int32))

  def initialize(@h, @w, @sy, @sx, @gy, @gx, @g)
    @costs = Array.new(h) { Array.new(w, INF) }
  end

  def self.read
    h, w = gets.to_s.split.map { |v| v.to_i }
    sy, sx = gets.to_s.split.map { |v| v.to_i - 1 }
    gy, gx = gets.to_s.split.map { |v| v.to_i - 1 }
    g = Array.new(h) { gets.to_s }
    new(h, w, sy, sx, gy, gx, g)
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def wall?(y, x)
    g[y][x] == '#'
  end

  def each_warp(y, x)
    (y - 2).upto(y + 2) do |ny|
      (x - 2).upto(x + 2) do |nx|
        next if (ny - y).abs + (nx - x).abs <= 1
        next if outside?(ny, nx)
        next if wall?(y, x)
        yield ny, nx
      end
    end
  end

  def each_walk(y, x)
    DIR[0,4].each do |dy,dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(y, x)
      yield ny, nx
    end
  end

  def solve
    q = Deque(Tuple(Int32,Int32,Bool,Int32)).new
    warps = Array.new(h){ Array.new(w, false) }
    q.unshift({sy, sx, false, 0})
    costs[sy][sx] = 0

    while q.size > 0
      y, x, warp, cost = q.shift
      # pp ({y,x,warp,cost})
      return cost if y == gy && x == gx

      if warp
        each_warp(y,x) do |ny,nx|
          next if costs[ny][nx] != INF
          costs[ny][nx] = cost
          q << {ny,nx,false,cost}
        end
      else
        if !warps[y][x]
          warps[y][x] = true
          q << {y,x,true,cost+1}
        end
        each_walk(y,x) do |ny,nx|
          next if costs[ny][nx] != INF
          costs[ny][nx] = cost
          q.unshift({ny,nx,false,cost})
        end
      end
    end
    return -1
  end
end

puts Grid.read.solve
