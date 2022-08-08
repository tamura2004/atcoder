# 期待値の線形性より
# E(Y-X) = E(Y) - E(X)
# 最大値の期待値 - 最小値の期待値
# 最大を固定
# 最小を固定

require "crystal/modint9"
require "crystal/fact_table"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort

# 最小値
mini = (0...n).sum do |i|
  (n - 1 - i).c(k-1) * a[i]
end

maxi = (0...n).sum do |i|
  i.c(k-1) * a[i]
end

ans = (maxi - mini) // n.c(k)
pp ans
