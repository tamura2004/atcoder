require "crystal/bit_set"

# グリッドグラフのビット表現
module BitGridGraph
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  class Graph
    getter h : Int32
    getter w : Int32
    getter g : Int64
    getter edge : Bool # 外周を0で囲う

    def initialize(@h, @w, @edge = true)
      raise "Too big! #{h} #{w}" if h * w > 30
      @g = 0_i64
    end

    def set(v)
      @g = v.to_i64
    end

    def [](y, x)
      raise "out of range #{y} #{x}" if out_of_range?(y, x)
      return 0 if edge?(y,x)
      k = y * w + x
      g.bit(k)
    end
    
    def []=(y, x, v)
      raise "out of range #{y} #{x}" if out_of_range?(y, x)
      return if edge?(y,x)
      k = y * w + x
      if v == 1
        @g = g.on k
      else
        @g = g.off k
      end
    end

    def out_of_range?(y, x)
      outside?(y,x) && !edge?(y,x)
    end

    def outside?(y, x)
      y < 0 || h <= y || x < 0 || w <= x
    end

    def edge?(y,x)
      y == -1 || x == -1 || y == h || x == w
    end

    def each(y, x)
      DIR[0, 4].each do |dy, dx|
        ny = y + dy
        nx = x + dx
        next if outside?(ny, nx)
        yield ny, nx
      end
    end

    def each
      h.times do |y|
        w.times do |x|
          yield y, x, g[y, x]
        end
      end
    end

    def debug
      h.times do |y|
        w.times do |x|
          print self[y, x]
        end
        puts
      end
    end
  end
end
