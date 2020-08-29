class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)
  def initialize
    @n,@c = gets.split.map(&:to_i)
    @d = Array.new(c){ gets.split.map(&:to_i) }
    @a = Array.new(n){ gets.split.map(&:to_i).map{_1-1} }
  end

  def init
    @dp = Array.new(3){ Array.new(c,0) }
    c.times do |i|
      n.times do |y|
        n.times do |x|
          j = a[y][x]
          @dp[(y+x)%3][i] += d[j][i]
        end
      end
    end
  end

  def solve
    init
    ans = 10**15
    c.times do |i|
      c.times do |j|
        next if i == j
        c.times do |k|
          next if i == k
          next if j == k
          v = @dp[0][i] + @dp[1][j] + @dp[2][k]
          ans = v if ans > v
        end
      end
    end
    ans
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
  # pp self
end