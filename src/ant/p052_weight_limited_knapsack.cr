require "crystal/problem"

# 重さ制限付きナップサック問題
#
# 重量制限*wmax*内で
# *n*個の品物の重さ*w*価値*v*の時
# 価値を最大化する
#
# ```
# input = <<-EOS
# 4 5
# 2 1 3 2
# 3 2 4 2
# EOS
# WeightLimitedKnapsack.read(input).solve # => 7
# ```
class WeightLimitedKnapsack < Problem
  getter n : Int32
  getter wmax : Int32
  getter w : Array(Int32)
  getter v : Array(Int64)

  def self.read(io : IO)
    n, wmax = io.gets.to_s.split.map(&.to_i)
    w = io.gets.to_s.split.map(&.to_i)
    v = io.gets.to_s.split.map(&.to_i64)
    new(n,wmax,w,v)
  end

  def initialize(@n,@wmax,@w,@v)
  end

  # dp[重さ] := 価値
  # dp[j] = dp[j - w[i]] + v[i]
  # ただしjは大きい順,
  def solve
    dp = Array.new(wmax+1, 0_i64)
    n.times do |i|
      wmax.downto(0) do |j|
        jj = j - w[i]
        next if jj < 0
        chmax dp[j], dp[jj] + v[i]
      end
    end
    return dp[-1]
  end
end

