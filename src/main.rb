require "numo/narray"

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @r,@c,@k = gets.split.map(&:to_i)
    @s = Array.new(r){ gets.chomp }
  end
  
  def init
    @g = Numo::Int64[
      [ 0, 0, 0, 1, 0, 0, 0],
      [ 0, 0, 0, 1, 0, 0, 0],
      [ 0, 0, 0, 0, 0, 0, 0],
      [-1,-1, 0, 0, 0,-1,-1],
      [ 0, 0, 0, 0, 0, 0, 0],
      [ 0, 0, 0, 1, 0, 0, 0],
      [ 0, 0, 0, 1, 0, 0, 0],
    ]
  end

  def left_down
    1.upto(6) do |y|
      0.upto(5) do |x|
        g[y,x] += g[y-1,x+1]
      end
    end
  end

  def right_down
    1.upto(6) do |y|
      1.upto(6) do |x|
        g[y,x] += g[y-1,x-1]
      end
    end
  end
  
  def solve
  end

  def show(ans)
    pp ans
  end
end

Problem.new.instance_eval do
  show(solve)
  init
  pp g
  left_down
  pp g
  right_down
  pp g
end