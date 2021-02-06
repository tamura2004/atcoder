class Problem
  attr_accessor :n, :x, :a, :memo

  def initialize
    @cnt = 0
    @n = gets.to_s.to_i
    @memo = Hash.new { |h, k| h[k] = nil }
  end

  def solve
    f(n)
  end

  def f(n)
    return memo[n] if memo[n]
    memo[n] = g(n)
  end

  def g(n)
    return n if n < 6

    ans = 1 << 60
    ans = f(n - 1) + 1

    base = 6
    while base <= n
      cnt = f(n - base) + 1
      ans = cnt if ans > cnt
      base *= 6
    end

    base = 9
    while base <= n
      cnt = f(n - base) + 1
      ans = cnt if ans > cnt
      base *= 9
    end

    return ans
  end
end

puts Problem.new.solve
