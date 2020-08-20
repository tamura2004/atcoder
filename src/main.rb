require "numo/narray"

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @r,@c,@k = gets.split.map(&:to_i)
    @s = Array.new(r){ gets.chomp }
    @m = k-1
  end
  
  # 愚直解
  def solve
    @g = Numo::Int64.zeros(r,c)
    each_x do |y,x|
      (-m).upto(m) do |dy|
        n = m - dy.abs
        (-n).upto(n) do |dx|
          next if y + dy < 0 || r <= y + dy 
          next if x + dx < 0 || c <= x + dx
          g[y+dy, x+dx] += 1
        end
      end
    end
    g[k-1..r-k,k-1..c-k].eq(0).count_true
  end
  
  # 横いもす法
  def solve2
    @g = Numo::Int64.zeros(r,c)
    each_x do |y,x|
      (-m).upto(m) do |dy|
        next if y + dy < 0 || r <= y + dy 
        n = m - dy.abs
        dx = [-n,0].max
        g[y+dy, x+dx] += 1
        
        if x + n < c
          g[y+dy, x+n] -= 1
        end
      end
    end
    r.times do |y|
      1.upto(c-1) do |x|
        g[y,x] += g[y,x-1]
      end
    end
    g[k-1..r-k,k-1..c-k].eq(0).count_true
  end
  
  def show(ans)
    pp ans
  end

  private

  def each_x
    r.times do |y|
      c.times do |x|
        next if s[y][x] == "o"
        yield y,x
      end
    end
  end
end

Problem.new.instance_eval do
  show(solve)
  pp g
  show(solve2)
  pp g
end