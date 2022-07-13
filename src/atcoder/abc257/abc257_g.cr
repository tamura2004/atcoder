# Tの部分文字列のうちSとprefixが一致するものを、[lo,hi)の区間の集合とみなす
# 最も少ない数で、Tを覆う区間の数が答え
# 最短路ともいえる。全探索でO(n^2)になるので工夫する
#
# 1. ロリハ二分探索で、ix[lo] := hiなるixを求める
# 2. セグ木でDPする。range_min準備してINFで初期化。dp[0]は0
# 3. 遷移：lo <- 0...n, dp[hi] = dp[lo..] + 1
# 4. dp[-1]が答え

require "crystal/indexable"
require "crystal/range"
require "crystal/segment_tree"
require "crystal/rolling_hash"

class Problem
  getter s : String
  getter t : String
  getter n : Int32
  getter m : Int32
  getter sh : RollingHash
  getter th : RollingHash
  # getter ix : Array(Int32)
  # getter dp : SegmentTree(Int64)

  def initialize(@s, @t)
    @n = s.size
    @m = t.size
    @sh = RollingHash.new(s)
    @th = RollingHash.new(t)

    # @ix = make_ix
  end

  def make_ix
    Array.new(m) do |lo|
      (lo...m).bsearch do |hi|
        len = (lo..hi).size
        len > n || sh[0, len] != th[lo, len]
      end || m
    end
  end

  def rec
    dp = (m + 1).to_st_min
    dp[0] = 0

    m.times do |lo|
      hi = ix[lo]
      next if lo == hi
      chmin dp[hi], dp[lo..] + 1 if dp[lo..] < Int64::MAX
    end
    dp
  end

  def solve
    dp = rec
    dp[m] == Int64::MAX ? -1 : dp[m]
  end
end

s = gets.to_s
t = gets.to_s
pr = Problem.new(s, t)
pp pr.solve
