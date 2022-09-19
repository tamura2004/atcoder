require "crystal/priority_queue"

alias Status = Tuple(Int32, Int32, Int32, Int32, Array(Array(Int32)))

class Problem
  getter h : Int32
  getter w : Int32
  getter gy : Int32
  getter gx : Int32
  getter root : Array(Array(Int32))
  getter goal : Array(Array(Int32))

  D = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]

  def initialize(@h, @w, @root)
    @gy = @gx = -1
    h.times do |y|
      w.times do |x|
        if root[y][x] == 0
          @gy = y
          @gx = x
        end
      end
    end

    @goal = Array.new(h) do |y|
      Array.new(w) do |x|
        y * w + x + 1
      end
    end
    @goal[-1][-1] = 0
  end

  def self.read
    h, w = gets.to_s.split.map(&.to_i)
    a = Array.new(h) { gets.to_s.split.map(&.to_i) }
    new(h, w, a)
  end

  def each(cnt, y, x, board)
    return if cnt >= 23
    D.each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      nb = board.map(&.dup)
      nb[y][x] = nb[ny][nx]
      nb[ny][nx] = 0
      ncost = cnt + 1 + calc_cost(nb)
      yield ncost, cnt + 1, ny, nx, nb
    end
  end

  def solve
    q = PQ(Status).lesser
    q << {0, 0, gy, gx, root}
    seen = Set(Array(Array(Int32))).new
    seen << root

    while q.size > 0
      _, cnt, y, x, a = q.pop
      if a == goal
        quit cnt
      end

      each(cnt, y, x, a) do |ncost, ncnt, ny, nx, na|
        next if seen.includes?(na)
        seen << na
        q << {ncost, ncnt, ny, nx, na}
      end
    end
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def calc_cost(a)
    h.times.sum do |y|
      w.times.sum do |x|
        v = a[y][x]
        if v.zero?
          0
        else
          oy, ox = (v-1).divmod(w)
          (oy - y).abs + (ox - x).abs
        end
      end
    end
  end
end

Problem.read.solve
pp 24
