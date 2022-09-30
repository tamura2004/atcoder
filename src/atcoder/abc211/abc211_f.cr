require "crystal/complex"
require "crystal/dual_segment_tree"

class Polygon
  enum Dir
    Left
    Right
    Query
  end

  getter n : Int32
  getter a : Array(C)

  def initialize(@n,@a)
  end
  
  def virtical_edges
    ans = [] of Tuple(Int64,Int64,Int64) # x, y_lo, y_hi
    n.times do |i|
      if a[i].x == a[i-1].x
        lo, hi = {a[i].y,a[i-1].y}.minmax
        ans << { a[i].x, lo, hi }
      end
    end
    ans.sort
  end

  def virtical_edges_with_dir
    st = DualSegmentTree.new(Array.new(100_001, 0), 0, -> (x : Int32, y : Int32) {x ^ y})
    ans = [] of Tuple(Int64,Dir,Int64,Int64) # x, dir, lo, hi
    virtical_edges.sort.each do |x, lo, hi|
      dir = st[lo].zero? ? Dir::Left : Dir::Right
      st[lo...hi] = 1
      ans << {x, dir, lo, hi}
    end
    ans
  end
end

class Problem
  getter n : Int32
  getter a : Array(Polygon)
  getter q : Int32
  getter queries : Array(C)

  def initialize(@n, @a,@q,@queries)
  end

  def self.read
    n = gets.to_s.to_i
    a = [] of Polygon
    n.times do
      m = gets.to_s.to_i
      z = [] of C
      gets.to_s.split.map(&.to_i64).each_slice(2) do |(x, y)|
        z << C.new(x,y)
      end
      a << Polygon.new(m, z)
    end
    q = gets.to_s.to_i
    queries = Array.new(q) do
      C.read
    end
    new(n, a, q, queries)
  end

  def solve
    events = [] of Tuple(Int64,Polygon::Dir,Int64,Int64)

    st0 = DualSegmentTree.new(Array.new(100_001, 0), 0, -> (x : Int32, y : Int32) {x ^ y})
    a.each do |polygon|
      hist = [] of Tuple(Int64,Int64)
      polygon.virtical_edges.each do |x, lo, hi|
        dir = st0[lo].zero? ? Polygon::Dir::Left : Polygon::Dir::Right
        events << {x, dir, lo, hi}
        hist << {lo,hi}
        st0[lo...hi] = 1
      end
      hist.each do |lo,hi|
        st0[lo...hi] = 1
      end
    end

    queries.each_with_index do |z, i|
      events << {z.x, Polygon::Dir::Query,z.y, i.to_i64}
    end
    
    events.sort!

    ans = Array.new(q, 0_i64)
    st = DualSegmentTree.new(Array.new(100_001,0_i64),0_i64,->(x : Int64, y : Int64){x+y})
    events.each do |x,cmd,lo,hi|
      case cmd
      when .left?
        st[lo...hi] = 1_i64
      when .right?
        st[lo...hi] = -1_i64
      when .query?
        ans[hi] = st[lo]
      end
    end
    puts ans.join("\n")
  end
end

Problem.read.solve
