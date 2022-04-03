module Abc168
  module F
    @[Flags]
    enum DIR
      Up
      Down
      Right
      Left
    end

    class CowGraph
      getter h : Int32
      getter w : Int32
      getter g : Array(Array(DIR))

      def initialize(@h, @w)
        raise "too small #{h} #{w}" if h < 2 || w < 2

        @g = Array.new(h) { Array.new(w, DIR::All) }

        h.times do |y|
          off(y, 0, DIR::Left)
          off(y, w - 1, DIR::Right)
        end

        w.times do |x|
          off(0, x, DIR::Up)
          off(h - 1, x, DIR::Down)
        end
      end

      def cut(y, x, dir)
        case dir
        when .up?
          off(y, x, DIR::Right)
          off(y, x + 1, DIR::Left)
        when .down?
          off(y + 1, x, DIR::Right)
          off(y + 1, x + 1, DIR::Left)
        when .left?
          off(y, x, DIR::Down)
          off(y + 1, x, DIR::Up)
        when .right?
          off(y, x + 1, DIR::Down)
          off(y + 1, x + 1, DIR::Up)
        end
      end

      def off(y, x, dir)
        g[y][x] &= (DIR::All ^ dir)
      end

      def on(y, x, dir)
        g[y][x] |= dir
      end

      def on?(y, x, dir)
        g[y][x] & dir != DIR::None
      end

      def off?(y, x, dir)
        g[y][x] & dir == DIR::None
      end

      def each(y, x)
        DIR.each do |d|
          yield y - 1, x if g[y][x].up?
          yield y + 1, x if g[y][x].down?
          yield y, x + 1 if g[y][x].right?
          yield y, x - 1 if g[y][x].left?
        end
      end

      def inspect
        v = Array.new(h*3) { Array.new(w*3, ' ') }
        h.times do |y|
          w.times do |x|
            v[y*3 + 1][x*3 + 1] = '*'
            v[y*3][x*3 + 1] = '|' if on?(y, x, DIR::Up)
            v[y*3 + 1][x*3] = '-' if on?(y, x, DIR::Left)
            v[y*3 + 1][x*3 + 2] = '-' if on?(y, x, DIR::Right)
            v[y*3 + 2][x*3 + 1] = '|' if on?(y, x, DIR::Down)
          end
        end
        v.reverse.map(&.join).join("\n")
      end
    end
  end
end
