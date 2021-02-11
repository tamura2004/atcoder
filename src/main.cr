
class Grid
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
  R = 0
  D = 1
  L = 2
  U = 3
  INF = Int32::MAX
  
  getter h : Int32
  getter w : Int32
  getter k : Int32
  getter sy : Int32
  getter sx : Int32
  getter gy : Int32
  getter gx : Int32
  getter g : Array(String)

  def initialize(@h, @w, @k, @g, @sy, @sx, @gy, @gx)
  end

  def self.read
    h, w, k = gets.to_s.split.map { |v| v.to_i }
    sy,sx,gy,gx = gets.to_s.split.map { |v| v.to_i - 1 }
    g = Array.new(h) { gets.to_s.chomp }
    new(h, w, k, g, sy, sx, gy, gx)
  end

  def each(y, x, dir)
    1.upto(k) do |i|
      ny = y + DIR[dir][0] * i
      nx = x + DIR[dir][1] * i
      break if outside?(ny, nx)
      break if wall?(ny,nx)
      yield ny, nx, (dir + 1) % 4
      yield ny, nx, (dir - 1) % 4
      yield ny, nx, dir if i == k
    end
  end

  def solve
    costs = Array.new(h) { Array.new(w) { Array.new(4, INF) } }
    q = Deque(Tuple(Int32,Int32,Int32)).new
    4.times do |dir|
      costs[sy][sx][dir] = 0
      q << {sy,sx,dir}
    end

    while q.size > 0
      y, x, dir = q.shift
      each(y, x, dir) do |ny, nx, ndir|
        next if costs[ny][nx][ndir] != INF
        costs[ny][nx][ndir] = costs[y][x][dir] + 1
        q << {ny, nx, ndir}
      end
    end
    # h.times do |y|
    #   puts costs[y].map(&.min).map{|i|i==INF ? '@' : i.to_s}.join(" ")
    # end
    ans = costs[gy][gx].min
    puts ans == INF ? -1 : ans
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def wall?(y, x)
    g[y][x] == '@'
  end
end

Grid.read.solve
