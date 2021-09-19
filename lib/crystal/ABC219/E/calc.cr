module Abc219
  module E
    def cover(a, b)
      4.times.all? do |i|
        4.times.all? do |j|
          a[i][j] != 1 || b[i][j] == 1
        end
      end
    end

    class ToArr
      getter n : Int32

      def initialize(@n)
      end

      def solve
        a = Array.new(4) { Array.new(4, 0) }
        4.times do |i|
          4.times do |j|
            k = i * 4 + j
            a[i][j] = n.bit(k)
          end
        end
        a
      end
    end

    class Connected
      getter a : Array(Array(Int32))
      getter seen : Array(Array(Bool))

      def initialize(@a)
        @seen = Array.new(4) { Array.new(4, false) }
      end

      def solve
        cnt = 0_i64
        4.times do |y|
          4.times do |x|
            next if a[y][x] == 0
            next if seen[y][x]
            bfs(y, x)
            cnt += 1
          end
        end
        cnt == 1
      end

      def bfs(iy, ix)
        seen[iy][ix] = true
        q = Deque.new([{iy, ix}])

        while q.size > 0
          y, x = q.shift

          [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].each do |dy, dx|
            ny = y + dy
            nx = x + dx

            next if ny < 0
            next if nx < 0
            next if ny >= 4
            next if nx >= 4
            next if a[ny][nx] == 0
            next if seen[ny][nx]

            seen[ny][nx] = true
            q << {ny, nx}
          end
        end
      end
    end

    class Hole
      getter a : Array(Array(Int32))
      getter seen : Array(Array(Bool))

      def initialize(@a)
        @seen = Array.new(4) { Array.new(4, false) }
      end

      def solve
        cnt = 0_i64
        4.times do |y|
          4.times do |x|
            next if a[y][x] == 1
            next if seen[y][x]
            bfs(y, x)
            cnt += 1
          end
        end
        cnt
      end

      def bfs(iy, ix)
        seen[iy][ix] = true
        q = Deque.new([{iy, ix}])

        while q.size > 0
          y, x = q.shift

          [{0, 1}, {0, -1}, {1, 0}, {-1, 0}].each do |dy, dx|
            ny = y + dy
            nx = x + dx

            next if ny < 0
            next if nx < 0
            next if ny >= 4
            next if nx >= 4
            next if a[ny][nx] == 1
            next if seen[ny][nx]

            seen[ny][nx] = true
            q << {ny, nx}
          end
        end
      end
    end
  end
end
