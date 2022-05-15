require "crystal/geography"

struct Polygon
  getter n : Int32
  getter points : Array(Point)
  getter lines : Array(Segment)
  
  def initialize(@n, @points)
    center = points.sum / n
    @points.sort_by!(&.phase)
    @lines = Array.new(n) do |i|
      Segment.new points[i-1], points[i]
    end
  end

  def move(x,y)
    po = @points.map do |z|
      z + Point.new(x,y)
    end
    Polygon.new(n,po)
  end

  def cross(b : self)
    pos = [] of Point
    ix = [] of Int32
    jx = [] of Int32

    n.times do |i|
      n.times do |j|
        if lines[i].intersect?(b.lines[j])
          pos << lines[i].crosspoint(b.lines[j])
          ix << i
          jx << j
        end
      end
    end

    return nil if pos.size <= 1

    n.times do |i|
      pos << points[i] if b.includes?(points[i])
    end

    n.times do |i|
      pos << b.points[i] if includes?(b.points[i])
    end

    Polygon.new(pos.size, pos)
  end

  def includes?(p : Point)
    ans = true
    n.times do |i|
      ans = false if (points[i-1] - p).cross(points[i] - p) < 0
    end
    ans
  end
  
  def resset_line
    @lines = Array.new(n) do |i|
      Segment.new points[i-1], points[i]
    end
  end
end

n = gets.to_s.to_i
xy = Array.new(n) do
  x,y = gets.to_s.split.map(&.to_i64)
  Point.new(x,y)
end

po = Polygon.new(n,xy)

m = gets.to_s.to_i
ms = [] of Polygon

m.times do
  u,v = gets.to_s.split.map(&.to_i64)
  ms << po.move(u,v)
end

q = gets.to_s.to_i64

mm = ms[0]
(1...m).each do |i|
  if mmm = mm.cross(ms[i])
    mm = mmm
  else
    q.times do
      puts "No"
    end
    exit
  end
end

q.times do
  x,y = gets.to_s.split.map(&.to_i64)
  if mm.includes?(Point.new(x,y))
    puts "Yes"
  else
    puts "No"
  end
end

