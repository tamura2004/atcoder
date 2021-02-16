class Problem
  getter n : Int32
  getter a : Array(Int64)
  getter dp : Array(Array(Int64?))

  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.split.map { |v| v.to_i64 }
    @dp = Array.new(n) { Array(Int64?).new(n, nil) }
    n.times { |i| dp[i][i] = a[i] }
  end

  def solve
    puts f(0, n-1)
  end

  def f(lo, hi)
    dp[lo][hi] ||= g(lo, hi)
  end

  def g(lo, hi)
    return a[lo] if lo == hi
    dp[lo][hi] = Math.max(
      a[lo] - f(lo + 1, hi),
      a[hi] - f(lo, hi - 1)
    )
  end
end

Problem.new.solve