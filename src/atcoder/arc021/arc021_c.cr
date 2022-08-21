# 二分探索の気配
# a1 +
# a1 + d1 +
# a1 + d1 + d1 +
#              |
# コストの最大値をxとしたとき、k回以上増築ができるか

require "big"

k = gets.to_s.to_i64
n = gets.to_s.to_i64
a, d = Array.new(n) do
  gets.to_s.split.map(&.to_i64)
end.transpose

# k = 1e8.to_i64
# n = 1_i64
# a = Array.new(n) { 1000_i64 }
# d = Array.new(n) { 1000_i64 }

ans = Problem.new(n, k, a, d).solve
pp ans

class Problem
  LO = 0.to_big_i
  HI = 1e20.to_big_i

  getter n : Int64
  getter k : Int64
  getter a : Array(Int64)
  getter d : Array(Int64)

  def initialize(@n, @k, @a, @d)
  end

  def solve
    max_cost = (LO..HI).bsearch do |x|
      query(x)
    end.not_nil!

    ans = 0.to_big_i
    m = 0_i64
    n.times do |i|
      next if max_cost <= a[i]
      cnt = 1.to_big_i + (max_cost - a[i] - 1) // d[i]
      ans += cnt * a[i]
      ans += cnt * (cnt - 1) // 2 * d[i]
      m += cnt
    end

    ans += max_cost * (k - m)

    ans
  end

  def query(v)
    cnt = 0_i64
    n.times do |i|
      next if v < a[i]
      return true if k <= cnt
      cnt += Math.min k - cnt, 1_i64 + (v - a[i]) // d[i]
    end
    k <= cnt
  end
end
