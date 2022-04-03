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
    @g = Array.new(h) { Array.new(w, DIR::All) }
    off(1,1,DIR::Right)
    off(1,2,DIR::Left)
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
    v.map(&.join).join("\n")
  end
end

g = CowGraph.new(3, 3)
pp g
