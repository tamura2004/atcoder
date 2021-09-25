# グリッドグラフのビット表現
module BitGridGraph
  DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

  struct Graph
    getter h : Int32
    getter w : Int32
    getter g : Int64
    delegate to_i64, popcount, hash, "&", "|", ">>", "<<", to: g

    # hash, == を定義するとhashのkeyにできる
    def ==(b : self)
      g == b.g
    end

    def initialize(@h, @w)
      raise "Too big! #{h} #{w}" if h * w > 64
      @g = 0_i64
    end

    def initialize(@h, @w, @g)
    end

    # g = Graph.new([
    #   "1011",
    #   "0101",
    #   "0010",
    #   "0001"
    # ])
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
        @g |= 1_i64 << k
      else
        @g &= ~(1_i64 << k)
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

    def to_a
      ans = [] of Int64
      gg = @g
      ww = 1_i64 << w

      h.times do
        ans << gg % ww
        gg //= ww
      end
      ans
    end

    def to_string_array
      to_a.map{|s| "%0#{w}b" % s }.map(&.reverse)
    end

    def to_s
      to_string_array.join
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
