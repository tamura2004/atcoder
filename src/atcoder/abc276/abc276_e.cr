# Sの隣接4点、Sを壁として最短路が答え
require "crystal/grid"

class Problem
  getter h : Int32
  getter w : Int32
  getter g : Grid

  def initialize(@h,@w,a)
    @g = Grid.new(@h,@w,a)
  end

  def self.read
    h,w = gets.to_s.split.map(&.to_i)
    a = Array.new(h){ gets.to_s }
    new(h,w,a)
  end

  def solve(root, goals)
    seen = Set(C).new
    seen << root
    q = Deque.new([root])
    
    while q.size > 0
      z = q.shift
      
      if z.in?(goals)
        return true
      end
      
      g.each(z) do |w|
        next if g[w] == 'S'
        next if seen.includes?(w)
        seen << w
        q << w
      end
    end
    return false
  end

  def query
    sz = C.zero
    g.each do |z|
      if g[z] == 'S'
        sz = z
        break
      end
    end

    goals = [] of C
    g.each(sz) do |z|
      goals << z
    end

    g.each(sz) do |z|
      if solve(z, goals - [z])
        quit "Yes"
      end
    end
    quit "No"
  end
end

Problem.read.query
