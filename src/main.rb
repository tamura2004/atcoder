
class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  DX = [ 0, 1, 0,-1, 1,-1, 1,-1]
  DY = [ 1, 0,-1, 0, 1,-1,-1, 1]

  def initialize
    @h,@w = gets.split.map(&:to_i)
    @c = gets.split.map(&:to_i)
    @d = gets.split.map(&:to_i)
    @s = Array.new(h){ gets.chomp }
  end

  def each_walk(y,x)
    4.times do |i|
      ny = y + DY[i]
      nx = x + DX[i]
      next if nx < 0 || w <= nx
      next if ny < 0 || h <= ny
      next if s[ny][nx] == "#"
      yield y,x
    end
  end
    
  def solve
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
  pp self
end