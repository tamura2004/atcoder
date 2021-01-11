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

alias Pair = Tuple(Int64, Int64)

n = gets.to_s.to_i
dp = [] of Pair
n.times do
  a,b = gets.to_s.split.map { |v| v.to_i64 }
  dp << Pair.new(a,b)
  dp << Pair.new(b,a)
end

dp.sort_by!{|e|{e[0],-e[1]}}
a = dp.map(&.last)
ans = LIS(Int64).new(a).solve
pp ans