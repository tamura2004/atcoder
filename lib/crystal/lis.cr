# 最長増加部分列(LIS)の長さを求める
#
# ```
# [1,3,5,2,6]の最長増加部分列は、[1,3,5,6]
# a = [1,3,5,2,6]
# lis = LIS(Int32).new(a)
# lis.solve # => 4
# ```
class LIS(T)
  getter a : Array(T)
  getter n : Int32

  def initialize(@a)
    @n = a.size
  end

  def solve
    dp = Array(T).new(n, T::MAX)
    n.times do |i|
      j = dp.bsearch_index{|v| a[i] <= v} || 0
      dp[j] = a[i]
    end
    dp.index(&.== T::MAX)
  end
end