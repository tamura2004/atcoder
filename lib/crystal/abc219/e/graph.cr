require "crystal/union_find_tree"

module Abc219
  module E
    DIR = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

    class Graph
      getter g : Array(Array(Int32))
      delegate "[]", to: g

      def initialize(@g)
      end

      def initialize(v : Int32)
        @g = Array.new(4){ Array.new(4, 0) }
        4.times do |y|
          4.times do |x|
            k = to_ix(y, x)
            g[y][x] = v.bit(k)
          end
        end
      end

      def initialize(s : String)
        @g = s.split.map(&.chars.map(&.to_i))
      end

      def initialize(s : Array(String))
        @g = s.map(&.chars.map(&.to_i))
      end

      def rot90!
        @g = g.reverse.transpose
      end

      def to_i
        ans = 0
        3.downto(0) do |y|
          3.downto(0) do |x|
            ans <<= 1
            ans += 1 if g[y][x] == 1
          end
        end
        ans
      end

      def bits_set?(mask : self)
        4.times.all? do |y|
          4.times.all? do |x|
            g[y][x] == 0 || (g[y][x] == 1 && mask[y][x] == 1)
          end
        end
      end

      def debug
        puts "=" * 10
        puts g.map(&.join(' ')).join("\n")
      end

      # 1,0それぞれの連結要素の数を返す
      # ただし外周を0に囲まれていると仮定
      def connected
        uf = UnionFindTree.new(17)
        4.times do |y|
          4.times do |x|
            each(y, x) do |ny, nx, outside|
              if outside
                next if g[y][x] != 0
                uf.unite to_ix(y,x), 16
              else
                next if g[y][x] != g[ny][nx]
                uf.unite to_ix(y,x),to_ix(ny,nx)
              end
            end
          end
        end

        uf.gsize
      end

      private def to_ix(y, x)
        y * 4 + x
      end

      def each(y,x)
        DIR[0, 4].each do |dy, dx|
          ny = y + dy
          nx = x + dx
          yield ny, nx, outside?(ny, nx)
        end
      end

      def inside?(y,x)
        x.in?(0...4) && y.in?(0...4)
      end

      def outside?(y,x)
        !inside?(y,x)
      end
    end
  end
end
