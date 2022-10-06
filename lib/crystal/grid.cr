require "crystal/complex"

# 文字列によるグリッド
# 利便性のため、参照に複素数を利用
class Grid
  getter h : Int32
  getter w : Int32
  getter a : Array(String)
  getter dir : Array(C)
  delegate "[]", to: a

  def initialize(@h, @w, @a = [] of String)
    @dir = [1.i]
    3.times { dir << dir[-1] * 1.i }
    3.times { dir << dir[-1] * (1.i + 1) }
  end

  def read
    @a = Array.new(h) { gets.to_s }
  end

  def each
    h.times do |y|
      w.times do |x|
        yield C.new(x,y)
      end
    end
  end

  def each_dir
    dir[0,4].each do |dz|
      yield dz
    end
  end

  def each_dir8
    dir.each do |dz|
      yield dz
    end
  end

  def each(z : C, wall = true)
    each_dir do |dz|
      nz = z + dz
      next if outside?(nz)
      next if wall && wall?(nz)
      yield nz
    end
  end

  def each8(z : C, wall = true)
    dir.each do |dz|
      nz = z + dz
      next if outside?(nz)
      next if wall && wall?(nz)
      yield nz
    end
  end

  def index(c : Char)
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
