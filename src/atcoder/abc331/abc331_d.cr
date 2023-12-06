require "crystal/cumulative_sum_2d"
require "crystal/matrix"

n, q = gets.to_s.split.map(&.to_i64)
values = Array.new(n) do
  gets.to_s.chars.map(&.==('B').to_unsafe.to_i64)
end
m = Matrix(Int64).new(values)
cs = CS2D.new(m)

pr = Problem.new(n, cs)

q.times do
  a, b, c, d = gets.to_s.split.map(&.to_i64)
  puts pr.solve(a, b, c, d)
end


class Problem
  getter n : Int64
  getter b_size : Int64
  getter cs : CS2D(Int64)

  def initialize(@n, @cs)
    @b_size = cs[0.y + 0.x...n.x + n.y]
  end

  def sum(y, x)
    ly = (y + 1) // n
    lx = (x + 1) // n

    sy = y % n
    sx = x % n

    ans = ly * lx * b_size
    ans += ly * cs[0.x + 0.y..sx.x + (n - 1).y] if sx < n - 1
    ans += lx * cs[0.x + 0.y..(n - 1).x + sy.y] if sy < n - 1
    ans += cs[0.x + 0.y..sx.x + sy.y] if sx < n - 1 && sy < n - 1
    ans
  end

  def solve(a, b, c, d)
    ans = sum(c, d)
    ans -= sum(c, b - 1) if b > 0
    ans -= sum(a - 1, d) if a > 0
    ans += sum(a - 1, b - 1) if b > 0 && a > 0
    ans
  end
end
