class Problem
  getter n : Int32
  getter d : Int32
  getter a : Array(Int64)
  getter ans : Float64

  def initialize(@n, @d, @a)
    @ans = Float64::MAX
  end

  def solve
    dfs([] of Int64, 0)
    pp ans
  end

  def dfs(acc, i)
    if i == n
      ave = acc.sum / d
      div = (0...d).sum do |i|
        ((acc[i]? || 0_i64) - ave) ** 2
      end / d
      chmin @ans, div
    else
      acc.each_index do |j|
        acc[j] += a[i]
        dfs(acc, i + 1)
        acc[j] -= a[i]
      end
      if acc.size < d
        acc << a[i]
        dfs(acc, i + 1)
        acc.pop
      end
    end
  end
end

n, d = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
Problem.new(n, d, a).solve
