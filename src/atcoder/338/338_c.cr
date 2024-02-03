# ニブタンを２回
require "crystal/range"

class Problem
  getter n : Int64
  getter q : Array(Int64)
  getter a : Array(Int64)
  getter b : Array(Int64)

  def initialize(@n, @q, @a, @b)
  end

  def self.read
    n = gets.to_s.to_i64
    q = gets.to_s.split.map(&.to_i64)
    a = gets.to_s.split.map(&.to_i64)
    b = gets.to_s.split.map(&.to_i64)
    new(n, q, a, b)
  end

  # 合計でK個以上作れるか
  def q1(k)
  end

  # aをk個、bをl個作れるか
  def q2(k, l)
    n.times.all? do |i|
      a[i] * k + b[i] * l <= q[i]
    end
  end

  def solve
    lo = 0_i64
    hi = 10_000_000_i64
    ans = (lo..hi).reverse_bsearch do |k|
      cnt = false
      (0..k).each do |ai|
        bi = k - ai
        if q2(ai, bi)
          cnt = true
        end
      end
      cnt
    end
  end
end

pr = Problem.read
pp pr.solve