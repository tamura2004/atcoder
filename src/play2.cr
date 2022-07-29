class Problem
  getter n : Int64
  getter a : Array(Int64)
  getter b : Array(Int64)

  def initialize(@n, @a, @b)
  end

  def solve
    ans = 29.times.sum do |i|
      calc(i) << i
    end
    pp ans
  end

  def calc(i)
    x = a.map(&.bit(i)).sum.to_i64
    y = b.map(&.bit(i)).sum.to_i64
    (n * x + n * y - x * y) % 2
  end
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

Problem.new(n, a, b).solve
