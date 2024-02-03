# 文字列によるグリッド表現
class Grid
  DIR = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}]
  private getter h : Int32
  private getter w : Int32
  private getter g : Array(String)

  def self.read(h)
    g = Array.new(h) { gets.to_s }
    new(g)
  end

  def initialize(@g)
    raise "文字列の幅が異なります: #{g}" if @g.map(&.size).uniq.size != 1

    @h = @g.size
    @w = @g.first.size
  end

  def [](y : Int32 | Int64) : String
    g[y]
  end

  def [](y : Int, x : Int) : Char
    g[y][x]
  end

  # タプルで座標指定可能
  def [](v : Tuple(Int32, Int32)) : Char
    self[*v]
  end

  def each(y : Int, x : Int, dir = 4, &)
    DIR[...dir].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      yield ({ny, nx})
    end
  end

  def each_with_char(y : Int, x : Int, dir = 4, &)
    DIR[...dir].each do |dy, dx|
      ny = y + dy
      nx = x + dx
      next if outside?(ny, nx)
      yield ({ny, nx, g[ny][nx]})
    end
  end

  def each(v : Tuple(Int32, Int32), dir = 4, &)
    each(*v, dir) do |nv|
      yield nv
    end
  end

  def each_with_index(v : Tuple(Int32, Int32), dir = 4, &)
    each(*v, dir) do |nv|
      yield self[nv], nv
    end
  end
  
  def each_with_index(v : Tuple(Int32, Int32), dir = 4) : Iterator(Tuple(Char, Int32, Int32))
    y, x = v

    DIR[...dir].compact_map do |dy, dx|
      ny = y + dy
      nx = x + dx
      if outside?(ny, nx)
        nil
      else
        {self[ny, nx], ny, nx}
      end
    end.each
  end

  def each(y : Int, x : Int, dir = 4) : Iterator(Tuple(Int32, Int32))
    DIR[...dir].compact_map do |dy, dx|
      ny = y + dy
      nx = x + dx
      if outside?(ny, nx)
        nil
      else
        {ny, nx}
      end
    end.each
  end

  def each(v : Tuple(Int32, Int32), dir = 4) : Iterator(Tuple(Int32, Int32))
    each(*v)
  end

  private def outside?(y, x) : Bool
    !inside?(y, x)
  end

  private def inside?(y, x) : Bool
    0 <= y < h && 0 <= x < w
  end
end
