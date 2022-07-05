record Point, x : Int64, y : Int64 do
  def initialize(x, y)
    @x = x.to_i64
    @y = y.to_i64
  end

  def self.zero
    Point.new 0_i64, 0_i64
  end

  def zero?
    x.zero? && y.zero?
  end

  def +(b : self)
    Point.new b.x + x, b.y + y
  end

  def -(b : self)
    Point.new b.x - x, b.y - y
  end

  def %(b : Int)
    Point.new x % b, y % b
  end

  def //(b : Int)
    Point.new x // b, y // b
  end

  def mul_x(b : Int)
    Point.new x * b, y
  end

  def mul_y(b : Int)
    Point.new x, y * b
  end

  def eq_x?(b : self)
    x == b.x
  end

  def eq_y?(b : self)
    y == b.y
  end

  def floor_x(b : Int)
    Point.new x // b * b, y
  end

  def floor_y(b : Int)
    Point.new x, y // b * b
  end

  def ceil_x(b : Int)
    Point.new (x + b - 1) // b * b, y
  end

  def ceil_y(b : Int)
    Point.new x, (y + b - 1) // b * b
  end

  def manhattan
    x.abs + y.abs
  end
end

struct Int
  def x
    Point.new self, 0_i64
  end

  def y
    Point.new 0_i64, self
  end
end

enum Place
  Cross
  Tate
  Yoko
  Other
end

enum Direction
  Up
  Down
  Right
  Left
end

class ABC258F
  getter b : Int64
  getter k : Int64

  def initialize(@b, @k)
  end

  def place(z)
    w = z % b
    case
    when w.zero?   then Place::Cross
    when w.x.zero? then Place::Tate
    when w.y.zero? then Place::Yoko
    else                Place::Other
    end
  end

  def street(z, d)
    case d
    when .up?    then z.ceil_y(b)
    when .down?  then z.floor_y(b)
    when .right? then z.ceil_x(b)
    else              z.floor_x(b)
    end
  end

  def streets(z)
    return [{z, 0_i64}] unless place(z).other?

    Direction.values.map do |d|
      w = street(z, d)
      cost = (w - z).manhattan * k
      {w, cost}
    end
  end

  def intersections(z)
    case place(z)
    when .other? then [] of {Point, Int64}
    when .cross? then [{z, 0_i64}]
    when .tate?
      [Direction::Up, Direction::Down].map do |d|
        w = street(z, d)
        cost = (w - z).manhattan
        {w, cost}
      end
    else
      [Direction::Right, Direction::Left].map do |d|
        w = street(z, d)
        cost = (w - z).manhattan
        {w, cost}
      end
    end
  end

  def solve(s, g)
    Math.min (s - g).manhattan * k, dist(s, g)
  end

  def dist(s, g)
    streets(s).min_of do |z, cost_z|
      streets(g).min_of do |w, cost_w|
        dist_between_street(z, w) + cost_z + cost_w
      end
    end
  end

  def dist_between_street(s, g)
    ans = case
          when place(s) == place(g) == Place::Tate && (s // b).eq_y?(g // b)
            (s - g).mul_x(k).manhattan
          when place(s) == place(g) == Place::Yoko && (s // b).eq_x?(g // b)
            (s - g).mul_y(k).manhattan
          else
            (s - g).manhattan
          end
    Math.min ans, dist_between_intersection(s, g)
  end

  def dist_between_intersection(s, g)
    intersections(s).min_of do |z, cost_z|
      intersections(g).min_of do |w, cost_w|
        (z - w).manhattan + cost_z + cost_w
      end
    end
  end
end

t = gets.to_s.to_i64
t.times do
  b, k, sx, sy, gx, gy = gets.to_s.split.map(&.to_i64)
  f = ABC258F.new(b, k)
  pp f.solve(sx.x + sy.y, gx.x + gy.y)
end
