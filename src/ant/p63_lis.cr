# dp[i]
#  | 長さi+1の増加部分列が存在 := 最終要素の最小値
#  | 存在しない := INF

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i64 }
dp = Array.new(n+1, Int64::MAX)

n.times do |i|
  j = dp.bsearch_index(&.>= a[i]) || 0
  dp[j] = a[i]
end

ans = dp.bsearch_index(&.== Int64::MAX) || -1
puts ans

# 5
# 4 2 3 1 5
# => 3 (1 3 5)