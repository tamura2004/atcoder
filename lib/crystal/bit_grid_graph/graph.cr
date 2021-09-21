require "crystal/bit_set"
require "crystal/union_find_tree"

# グリッドグラフのビット表現
module BitGridGraph
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  class Graph
    getter h : Int32
    getter w : Int32
    getter g : Int64
    delegate to_i64, to: g

    def initialize(@h, @w)
      raise "Too big! #{h} #{w}" if h * w > 64
      @g = 0_i64
    end

    def initialize(@h,@w,@g)
    end

    def initialize(s : Array(String))
      @h = s.size
      @w = s.first.size
      @g = 0_i64
      s.map(&.reverse.to_i(2)).reverse_each do |row|
        @g <<= w
        @g |= row
      end
    end

    def set(v)
      @g = v.to_i64
    end

    def [](y, x)
      raise "out of range #{y} #{x}" if outside?(y, x)
      k = y * w + x
      g.bit(k)
    end
    
    def []=(y, x, v)
      raise "out of range #{y} #{x}" if outside?(y, x)
      k = y * w + x
      if v == 1
        @g = g.on k
      else
        @g = g.off k
      end
    end

    def outside?(y, x)
      y < 0 || h <= y || x < 0 || w <= x
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
          yield y, x, self[y, x]
        end
      end
    end

    def ix(y, x)
      y * w + x
    end

    def n
      h * w
    end

    def each_with_outside(y, x)
      DIR[0, 4].each do |dy, dx|
        ny = y + dy
        nx = x + dx
        yield ny, nx, outside?(ny, nx)
      end
    end

    def connect
      uf = UnionFindTree.new(n + 1)
      each do |y, x|
        each_with_outside(y, x) do |ny, nx, outside|
          if outside
            uf.unite ix(y, x), n if self[y,x] == 0
          else
            uf.unite ix(ny, nx), ix(y, x) if self[ny, nx] == self[y, x]
          end
        end
      end

      uf.gsize
    end

    def next_candidate
      each do |y,x|
        next if self[y,x] == 1 # 黒く塗る候補
        each(y,x) do |ny,nx|
          if self[ny,nx] == 1
            yield g.on ix(y,x)
            break
          end
        end
      end
    end
    
    def debug
      puts "===DEBUG==="
      h.times do |y|
        w.times do |x|
          print self[y, x]
        end
        puts
      end
    end
  end
end
