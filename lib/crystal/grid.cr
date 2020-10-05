class Grid
  DIR = [{0,1},{1,0},{0,-1},{-1,0}]

  getter h : Int32
  getter w : Int32
  getter c : Array(String)

  def initialize(@h,@w,@c)
  end

  def each(y,x)
    DIR.each do |dy,dx|
      ny = y + dy
      nx = x + dx
      next if outside(ny,nx)
      next if c[ny][nx] == '#'
      yield ny, nx
    end
  end

  def outside(y,x)
    y < 0 || h <= y || x < 0 || w <= x
  end
end