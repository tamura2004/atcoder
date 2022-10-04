require "crystal/graph/i_graph"
require "crystal/graph/i_tree"

class Grid
  include IGraph

  DIR = [{-1, 0}, {1, 0}, {0, 1}, {0, -1}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}]

  getter h : Int32
  getter w : Int32
  getter g : Array(String)
  getter n : Int32
  getter m : Int32
  getter both : Bool
  getter origin : Int32

  def initialize(h, w, @g)
    @h = h.to_i
    @w = w.to_i
    @n = h * w
    @m = h * (w - 1) + (h - 1) * w
    @both = true
    @origin = 0
  end

  def each : Iterator(Int32)
    (h*w).times
  end

  def each
    h.times do |y|
      w.times do |x|
        next if wall?(y, x)
        yield y * w + x
      end
    end
  end

  def each(v : Int32)
    y, x = v.divmod(w)

    DIR[0,4].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(ny, nx)
      yield ny * w + nx
    end
  end

  def each_with_cost(v)
    each(v) do |nv|
      yield nv, 1_i64
    end
  end

  def each8(v)
    y, x = v.divmod(w)

    DIR.each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      next if wall?(ny, nx)
      yield ny * w + nx
    end
  end

  def wall?(y, x, w = '#')
    g[y][x] == w
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end
end
