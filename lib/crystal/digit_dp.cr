class DigitDP
  getter n : Int32
  getter num : Array(Int32)

  def initialize(n : String)
    @num = n.chars.map(&.to_i)
    @n = num.size
  end

  def self.read
    n = gets.to_s.chomp
    new(n)
  end

  def solve
    free = Array.new(n + 1) { Array.new(n + 1, 0_i64) }
    edge = Array.new(n + 1) { Array.new(n + 1, 0_i64) }
    edge[0][0] += 1

    n.times do |i|
      (n + 1).times do |j|
        10.times do |d|
          z = d == 1 ? 1 : 0
          next if j - z < 0
          free[i + 1][j] += free[i][j - z]
          edge[i + 1][j] += edge[i][j - z] if d == num[i]
          free[i + 1][j] += edge[i][j - z] if d < num[i]
        end
      end
    end

    edge[-1].zip(0..).sum { |a, b| a*b } +
    free[-1].zip(0..).sum { |a, b| a*b }
  end

  def solve2
    maxi = num.join.to_i
    (1..maxi).sum do |v|
      v.to_s.chars.count &.== '1'
    end
  end

  def run
    puts solve
  end
end
