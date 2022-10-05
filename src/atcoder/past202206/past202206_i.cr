# 素抜け君の位置と荷物の位置の数字４つを状態としてもつ
require "crystal/complex"

class Grid
  getter h : Int32
  getter w : Int32
  getter a : Array(String)
  delegate "[]", to: a

  def initialize(@h, @w, @a)
  end

  def each
    h.times do |y|
      w.times do |x|
        yield C.new(y, x)
      end
    end
  end

  def index(c)
    each do |z|
      return z if self[z] == c
    end
    raise "no #{c}"
  end

  def [](z : C) : Char
    a[z.y][z.x]
  end

  def outside?(y : Int, x : Int) : Bool
    y < 0 || h <= y || x < 0 || w <= x
  end

  def outside?(z : C) : Bool
    outside?(z.y, z.x)
  end

  def wall?(y : Int, x : Int) : Bool
    a[y][x] == '#'
  end

  def wall?(z : C) : Bool
    wall?(z.y, z.x)
  end
end

class Problem
  getter g : Grid
  getter sz : C
  getter az : C
  getter gz : C
  delegate "index", "outside?", "wall?", to: g

  def initialize(@g)
    @sz = index('s')
    @az = index('a')
    @gz = index('g')
  end

  def self.read
    h, w = gets.to_s.split.map(&.to_i)
    a = Array.new(h) { gets.to_s }
    g = Grid.new(h, w, a)
    new(g)
  end

  def solve
    init = {sz, az, 0_i64}
    q = Deque.new([init])
    seen = Set(Tuple(C, C)).new
    seen << {sz, az}

    while q.size > 0
      sz, az, cnt = q.shift
      quit cnt if az == gz

      [1.y, -1.y, 1.x, -1.x].each do |dz|
        nsz = sz + dz
        next if outside?(nsz)
        next if wall?(nsz)

        naz = nsz == az ? az + dz : az
        next if outside?(naz)
        next if wall?(naz)

        nstate = {nsz, naz}
        next if nstate.in?(seen)

        seen << nstate
        q << {nsz, naz, cnt + 1}
      end
    end
    quit -1
  end
end

Problem.read.solve
