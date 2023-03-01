require "crystal/complex"

class Problem
  getter s : C
  getter t : C
  getter o : C
  getter a : Int64
  getter b : Int64
  getter c : Int64
  getter d : Int64
  getter ans : Array(C)

  def initialize(@s,@t,@a,@b,@c,@d)
    @o = a.x + c.y
    @ans = [] of C
  end

  def flip(p)
    ans << p
    @s = p * 2 - s
  end

  def solve
    flip(o) if a == b && s.x != t.x
    flip(o) if c == d && s.y != t.y

    if a != b
      while s.x < t.x
        flip(o)
        flip(o + 1.x)
      end
      while s.x > t.x
        flip(o + 1.x)
        flip(o)
      end
    end

    if c != d
      while s.y < t.y
        flip(o)
        flip(o + 1.y)
      end
      while s.y > t.y
        flip(o + 1.y)
        flip(o)
      end
    end

    if s == t
      puts "Yes"
      ans.each do |z|
        puts "#{z.x} #{z.y}"
      end
    else
      puts "No"
    end
  end
end

s = C.read.flip
t = C.read.flip
a,b,c,d = gets.to_s.split.map(&.to_i64)
Problem.new(s,t,a,b,c,d).solve
