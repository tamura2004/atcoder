require "crystal/mod_int"
require "crystal/fact_table"

# ラグランジュ補間
#
# n次多項式fがあって、y[i] = f(0), f(1), ... f(n)が与えられたとき
# f(t)を求める
#
# ```
# y = [10,20]
# t = 2
# LagrangePolynomial.new(y,t).solve # => 30
# ```
class LagrangePolynomial
  getter y : Array(Int64)  
  getter n : Int32
  getter t : Int64

  def initialize(y, t)
    @y = y.map(&.to_i64)
    @n = y.size - 1
    @t = t.to_i64
  end

  def solve
    return y[t] if t <= n
    ans = 0.to_m
    dp = Array.new(n+1, 1.to_m)
    pd = Array.new(n+1, 1.to_m)

    n.times do |i|
      dp[i+1] = dp[i] * (t - i)
    end

    (1..n).reverse_each do |i|
      pd[i - 1] = pd[i] * (t - i)
    end

    (0..n).each do |i|
      cnt = dp[i] * pd[i] * y[i] * i.finv * (n - i).finv
      if (n - i).odd?
        ans -= cnt
      else
        ans += cnt
      end
    end
    
    ans
  end
end
