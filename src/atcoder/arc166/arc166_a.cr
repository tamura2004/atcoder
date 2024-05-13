class Problem
  getter n : Int32
  getter x : Array(Char)
  getter y : Array(Char)

  def initialize(@n, @x, @y)
  end

  def solve
    y.zip(x).chunks(&.[0].== 'C').map(&.last.transpose).each do |(yy, xx)|
      return false if unmatch(yy, xx)
    end
    true
  end

  def run
    yesno solve
  end

  def unmatch(z, w)
    if z.first == 'C'
      w.any?(&.!= 'C')
    else
      za = z.count('A')
      zb = z.count('B')
      wa = w.count('A')
      wb = w.count('B')

      return true unless wa <= za && wb <= zb

      w.each_index do |i|
        next unless w[i] == 'C'
        if za - wa > 0
          w[i] = 'A'
          wa += 1
        else
          w[i] = 'B'
        end
      end

      zi = z.zip(0..).select(&.[0].== 'A').map(&.last)
      wi = w.zip(0..).select(&.[0].== 'A').map(&.last)

      !wi.zip(zi).all? { |i, j| i <= j }
    end
  end
end

t = gets.to_s.to_i64
t.times do
  n, x, y = gets.to_s.split
  Problem.new(n.to_i, x.chars, y.chars).run
end
