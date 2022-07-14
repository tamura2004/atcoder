class Problem
  getter n : Int32
  getter m : Int32
  getter x : Array(Int64)
  getter y : Array(Int64)

  def initialize(@n, @m, @x, @y)
  end

  def solve
    a = [0_i64]
    b = [0_i64]
    ans = Int64::MIN

    n.times do |i|
      a << a[-1] + sum(b[-1], x[i], y[i])
      b << b[-1] + x[i] * y[i]

      if i.zero?
        ans = x[i]
      else
        if b[-2] >= 0 && b[-1] < 0
          j = b[-2] // x[i].abs
          cnt = a[-2] + sum(b[-2], x[i], j)
          chmax ans, cnt
        end
      end

      chmax ans, a[-1]
    end

    ans
  end

  def sum(init, r, n)
    init * n + (1_i64..n).sum * r
  end
end

t = gets.to_s.to_i64
t.times do
  n, m = gets.to_s.split.map(&.to_i)
  x, y = Array.new(n) do
    gets.to_s.split.map(&.to_i64)
  end.transpose

  pp Problem.new(n, m, x, y).solve
end
