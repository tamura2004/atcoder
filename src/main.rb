require "numo/narray"

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @r,@c,@k = gets.split.map(&:to_i)
    @s = Array.new(r){ gets.chomp }
    @m = k-1
    @g = Numo::Int64.zeros(r,c)
  end

  def each
    r.times do |y|
      c.times do |x|
        yield y,x
      end
    end
  end

  def each_diamond(y,x)
    m = k - 1
    (-m).upto(m) do |dy|
      ny = y + dy
      next if ny < 0 || r <= ny
      n = m - dy.abs
      yield ny, [x - n, 0].max, 1
      yield ny, x + n + 1, -1
    end
  end

  def check(g)
    each do |oy,ox|
      next if s[oy][ox] != "x"
      each_diamond(oy,ox) do |y,x,v|
        next if c <= x
        g[y,x] += v
      end
    end
  end

  def csum(g)
    each do |y,x|
      next if x.zero?
      g[y,x] += g[y,x-1]
    end
  end

  def check_area(g)
    g[k-1..r-k,k-1..c-k]
  end

  def count(g)
    check_area(g).eq(0).count_true
  end

  def solve
    check(g)
    csum(g)
    count(g)
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
end