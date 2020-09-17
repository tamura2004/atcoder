OFFSET = 80*80

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  def initialize
    @h, @w = gets.split.map &:to_i
    @a = Array.new(h) { gets.split.map &:to_i }
    @b = Array.new(h) { gets.split.map &:to_i }
    @c = Array.new(h){ |y| Array.new(w){ |x| a[y][x] - b[y][x] } }
  end
  
  def each_grid
    h.times do |y|
      w.times do |x|
        yield y - 1, x, y, x if y != 0
        yield y, x - 1, y, x if x != 0
      end
    end
  end

  def solve
    dp = Array.new(h) { Array.new(w, 0) }
    dp[0][0] |= 1 << (OFFSET + c[0][0])
    dp[0][0] |= 1 << (OFFSET - c[0][0])
    
    each_grid do |y, x, ny, nx|
      dp[ny][nx] |= dp[y][x] << c[ny][nx].abs
      dp[ny][nx] |= dp[y][x] >> c[ny][nx].abs
    end
    
    dp[-1][-1]
  end  

  def show(ans)
    0.upto(OFFSET) do |i|
      if ans[OFFSET + i] | ans[OFFSET - i] == 1
        puts i
        exit
      end
    end
  end  
end  

Problem.new.instance_eval do
  show(solve)
end  
