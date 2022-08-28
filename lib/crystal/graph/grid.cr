require "crystal/graph/i_graph"

class Grid
  include IGraph

  DIR = [{-1, 0}, {1, 0}, {0, 1}, {0, -1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}]

  getter h : Int32
  getter w : Int32
  getter g : Array(String)
  getter n : Int32
  getter both : Bool
  getter origin : Int32

  def initialize(h, w, @g)
    @h = h.to_i
    @w = w.to_i
    @n = h * w
    @both = true
    @origin = 0
  end

  def each(&b : Int32 -> _)
    h.times do |y|
      w.times do |x|
        b.call y * w + x
      end
    end
  end

  def each(v, &b : Int32 -> _)
    y, x = v.divmod(w)

    DIR[0,4].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(ny, nx)
      b.call ny * w + nx
    end
  end

  def each8(v, &b : Int32 -> _)
    y, x = v.divmod(w)

    DIR.each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(ny, nx)
      b.call ny * w + nx
    end
  end

  def wall?(y, x, w = '#')
    g[y][x] == w
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end
end