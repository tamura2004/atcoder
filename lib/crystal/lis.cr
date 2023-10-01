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
    dp = Array(T).new(n + 1, T::MAX)
    a.each do |v|
      j = dp.bsearch_index(&.>= v) || 0
      dp[j] = v
    end
    dp.index(&.== T::MAX) || n
  end
end

class Array(T)
  def lis
    LIS(T).new(self).solve
  end
end
