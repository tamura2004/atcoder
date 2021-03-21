require "crystal/problem"

# 個数制限なしナップサック
#
# 重さと価値がそれぞれ*w[i]*,*v[i]*であるような*n*種類の品物があるとき
# 重さの総和が*wmax*を超えないように選んだ時の価値の総和の最大値を求める。
# ただし、同じ種類の品物をいくつでも選ぶことができる。
#
# ```
# input = <<-EOS
# 3 7
# 3 4 2
# 4 5 3
# EOS
# NumberUnlimitedKnapsack.read(input).solve # => 10
# ```
class NumberUnlimitedKnapsack < Problem
  getter n : Int32
  getter wmax : Int32
  getter w : Array(Int32)
  getter v : Array(Int64)

  def self.read(io : IO)
    n, wmax = io.gets.to_s.split.map(&.to_i)
    w = io.gets.to_s.split.map(&.to_i)
    v = io.gets.to_s.split.map(&.to_i64)
    new(n, wmax, w, v)
  end

  def initialize(@n, @wmax, @w, @v)
  end

  # 動的計画法で価値の総和の最大値を求める
  #
  # dp[重さの最大] := 価値の最大
  def solve
    dp = Array.new(wmax + 1, 0_i64)
    n.times do |i|
      0.upto(wmax) do |j|
        jj = j + w[i]
        next if jj > wmax
        chmax dp[jj], dp[j] + v[i]
      end
    end
    return dp[-1]
  end
end
